class VotesController < ApplicationController
  def index
	@session_identifier = params[:session]

	@chambers = params[:chambers]

	@origin = params[:origin]

	@result = params[:result]

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




	@origin_chamber_house = false
	@origin_chamber_senate = false

	if @origin

		@origin.each do |c|
			if c == 'house'
				@origin_chamber_house = true
			elsif c == 'senate'
				@origin_chamber_senate = true
			end
			
		end
	else
		@origin_chamber_house = true
		@origin_chamber_senate = true
	end


	#@current_session = AppConfiguration.where(:name => 'current_session').first

	#@session = Session.where(:session_identifier => @current_session.value).first

	if not @session_identifier
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@session_identifier = @current_session.value
	end	

	@roll_calls = RollCall.joins(:bill).joins(:action).where('bills.session_identifier' => @session_identifier)

	if @chamber_senate and not @chamber_house
		@roll_calls = @roll_calls.where(:location => 's')
		
	elsif @chamber_house and not @chamber_senate
		@roll_calls = @roll_calls.where(:location => 'h')
	end

	if @origin_chamber_senate and not @origin_chamber_house
		@roll_calls = @roll_calls.where("bills.bill_type like 's%'")
		
	elsif @origin_chamber_house and not @origin_chamber_senate
		@roll_calls = @roll_calls.where("bills.bill_type like 'h%'")
	end


	if @result == 'pass'
		@roll_calls = @roll_calls.where("roll_calls.result = 'PASSED'")
	elsif @result == 'fail'
		@roll_calls = @roll_calls.where("roll_calls.result = 'LOST'")
	end

	@roll_calls = @roll_calls.paginate(:page => params[:page], :per_page => 50)


	@sessions = Session.where(:enabled => 1).order('session_identifier DESC')

	@session = Session.find(@session_identifier)

	@title = 'List of Votes for ' + @session.session_label

	add_breadcrumb "Votes", ""

  end
end
