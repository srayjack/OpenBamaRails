class BillsController < ApplicationController

  def index

	add_breadcrumb "Bills", ""

	
	@session_identifier = params[:session]

	@chambers = params[:chambers]
	
	@type = params[:type]
	
	@status = params[:status]
	
	@sponsor = params[:sponsor]
	
	@subject = params[:subject]

	@text = params[:text]

	@tag = params[:tag]


	@chamber_house = false
	@chamber_senate = false

	if @chambers

		@chambers.each do |c|
			if c == 'house'
				@chamber_house = true
			elsif c == 'senate'
				@chamber_senate = true
			end
			
		end
	else
		@chamber_house = true
		@chamber_senate = true
	end


	if not @session_identifier
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@session_identifier = @current_session.value
	end


	if @chamber_house and @chamber_senate
		@bills = Bill.where(:session_identifier => @session_identifier)
	elsif @chamber_senate
		@bills = Bill.includes( :bill_statuses ).where(:session_identifier => @session_identifier).where("bills.bill_type like 's%'")
	elsif @chamber_house
		@bills = Bill.includes( :bill_statuses ).where(:session_identifier => @session_identifier).where("bills.bill_type like 'h%'")
	end

	if @text and @text != ''
		@bills = @bills.includes(:bill_text_version_contents).where("match(bills_text_versions_contents.bill_text_content,bills.description) against (? IN BOOLEAN MODE)",@text)
	end

	if @type == 'resolution'
		@bills = @bills.where("bills.bill_type like '%r%'")
	elsif @type == 'bill'
		@bills = @bills.where("bills.bill_type not like '%r%'")
	end

	if @sponsor and @sponsor.to_i > 0
		@bills = @bills.where(:sponsor_id => @sponsor.to_i)
	end

	if @subject and @subject.to_i > 0
		@bills = @bills.includes(:bill_subjects).where('bills_subjects.subject_id = ?', @subject.to_i)
	end

	if @tag and @tag.to_i > 0
		@bills = @bills.includes(:bill_tags).where('bills_tags.tag_id = ?', @tag.to_i)
	end

	if @status and @status.length > 0 and @status != 'all'
		@bills = @bills.where('? = (select bill_status from bills_statuses where bills_statuses.bill_id = bills.id order by bills_statuses.status_date desc limit 1)',@status)

	end
        @bills = @bills.order(:bill_type).order(:number)

	@bills = @bills.paginate(:page => params[:page], :per_page => 50)

	@sessions = Session.where(:enabled => 1).order('session_identifier DESC')

	@legislators = Person.where(:isActive => 1)

	@subjects = Subject.all
	
	@session = Session.find(@session_identifier)

	@tags = Tag.where("tag_name <> ''")

	@title = @session.session_label + ' Bills '

	respond_to do |format|
	  format.html # show.html.erb
	  #format.xml  { render :xml => @bills }
	  format.json { render :json => @bills }
	end
  end
end
