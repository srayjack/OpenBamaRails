class ApiController < ApplicationController
  def index
	add_breadcrumb "API", ""
	@title = 'Use the OpenBama data - Application Programming Interface (API)'
	@description = "Download the data that powers OpenBama!"

  end

  def sessions
	@sessions = Session.select('session_identifier, session_label').where(:enabled => 1)

	respond_to do |format|
	  format.html { render :json => @sessions }
	  format.xml  { render :xml => @sessions }
	  format.json { render :json => @sessions }
	end
  end

  def bills
	@session_identifier = params[:session]

	if not @session_identifier
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@session_identifier = @current_session.value
	end

	@bills = Bill.select('id, session_identifier, bill_type, number as bill_number, date_format(introduced,"%Y/%m/%d") as introduced, sponsor_id,description,subject,current_alison_status as current_long_status,last_status as current_short_status').where(:session_identifier => @session_identifier).where(:disabled => 0)

	respond_to do |format|
	  format.html { render :json => @bills }
	  format.xml  { render :xml => @bills }
	  format.json { render :json => @bills }
	end
  end

  def bill
	@id = params[:id]
	
	if @id 
		@bill = Bill.find(@id)
	end

	respond_to do |format|
	  format.html { render :json => @bill.to_json(:include => :actions) }
	  format.xml  { render :xml => @bill }
	  format.json { render :json => @bill.to_json(:include => :actions) }
#render :json => @export_data.to_json(:include => { :modelb => { :only => :name }})
	end
  end

  def bill_status
	@bill_type = params[:bill_type]
	@bill_number = params[:bill_number]

	@current_session = AppConfiguration.where(:name => 'current_session').first
	@session_identifier = @current_session.value

	@bill = nil
	
	if @bill_type and @bill_number
		@bill = Bill.where(:session_identifier => @session_identifier).where(:bill_type => @bill_type).where(:number => @bill_number).select('id,bill_type,number as bill_number,introduced,sponsor_id,(select full_name from people where people.id = sponsor_id) as sponsor, description,subject')
		#@bill = Bill.where(:session_identifier => @session_identifier).where(:bill_type => @bill_type).where(:number => @bill_number)
	end

	if @bill.count() == 0 
		@bill = '<message>No Results</message>'
		respond_to do |format|
		  format.html { render :json => @bill }
		  format.xml  { render :xml => @bill }
		  format.json { render :json => @bill.to_json }
		end

	else
		respond_to do |format|
		  format.html { render :json => @bill.to_json(:include => :actions) }
		  format.xml  { render :xml => @bill.to_xml(:methods => [:current_status]) }
		  format.json { render :json => @bill.to_json }
		end		
	end


  end

  def legislators
	@legislators = Person.where(:isActive => 1)

	respond_to do |format|
		format.html { render :json => @legislators.to_json() }
		#format.xml  { render :xml => @legislators }
  		format.json { render :json => @legislators.to_json() }
  	end
  end

  def legislator
	@id = params[:id]

	@legislator = Person.find(@id)

	respond_to do |format|
		format.html { render :json => @legislator.to_json() }
		#format.xml  { render :xml => @legislator }
  		format.json { render :json => @legislator.to_json() }
  	end
  end

  def lobbyists
	@year = params[:year]
	
	@lobbyists = Lobbyist.includes(:lobbyist_registrations).where('lobbyist_registrations.year_registered = ?',@year)
	
	respond_to do |format|
		format.html { render :json => @lobbyists.to_json() }
		#format.xml  { render :xml => @lobbyists }
  		format.json { render :json => @lobbyists.to_json() }
  	end
  end

  def lobbyist
	@id = params[:id]

	@lobbyist = Lobbyist.includes(:clients).find(@id)

	respond_to do |format|
		format.html { render :json => @lobbyist.to_json(:include => {:clients => {:only => [:id, :display_name]}}) }
		#format.xml  { render :xml => @lobbyist }
  		format.json { render :json => @lobbyist.to_json(:include => :clients) }
  	end
  end
end
