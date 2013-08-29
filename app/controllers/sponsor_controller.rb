class SponsorController < ApplicationController
  def index
	@session_identifier = params[:session]
	@id = params[:id]
	if not @session_identifier
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@session_identifier = @current_session.value
	end
	
	@session = Session.find(@session_identifier)
	@sessions = Session.where(:enabled => 1).order('session_identifier DESC')
	@legislator = Person.find(@id)
	@sponsored_bills = Bill.where(:session_identifier => @session_identifier).where(:sponsor_id => @legislator.id).order('introduced desc')
	@cosponsored_bills = Bill.where(:session_identifier => @session_identifier).joins(:bill_cosponsors).where('bills_cosponsors.person_id' => @legislator.id)
	@count = @sponsored_bills.count + @cosponsored_bills.count

	@title = "Bills sponsored by " + @legislator.full_name + " during " + @session.session_label
	@legislator_title = @legislator.full_name + ' [' + @legislator.party + '-' + @legislator.district + ']'
	add_breadcrumb 'Legislators','/legislators'
	add_breadcrumb @legislator_title, '/legislator/' + @id.to_s
	add_breadcrumb @title, ""
  end

end
