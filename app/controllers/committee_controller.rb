class CommitteeController < ApplicationController

	def index
		@id = params[:id]

		cookies[:visitor] = PageViewProcess.process_page_view('committee', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])


		@committee = Committee.find(@id)

		@title = "Detail for committee " + @committee.committee_name

		add_breadcrumb "Committees", "/committees"

		if @committee.house == 'h'
			add_breadcrumb "House", "/committees/index?chambers%5B%5D=house"
		elsif @committee.house == 's'
			add_breadcrumb "Senate","/committees/index?chambers%5B%5D=senate"
		end

		add_breadcrumb @committee.committee_name, ""

		@current_session = AppConfiguration.where(:name => 'current_session').first

		#@committee_members = @committee.people.where('committees_people.session_identifier = ?', @current_session.value)
		@committee_members = CommitteePerson.where(:committee_id => @committee.id).where(:session_identifier => @current_session.value).sort_by{|p| p[:roll_rank]}

		@bills = @committee.bills.where('bills.session_identifier = ?',@current_session.value)

		@current_bills = Bill.where(:session_identifier => @current_session.value).where(:current_committee_id => @id)

		if @committee.isSubcommittee
			@parent_committee = Committee.where(:committee_name => @committee.committee_name).where(:isSubcommittee => 0).first
		else
			@parent_committee = false
		end
	end
end
