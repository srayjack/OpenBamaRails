class CommitteesController < ApplicationController

	def index
		@chambers = params[:chambers]

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

		@committees = Committee.where("IFNULL(isSubcommittee, 0) <> 1")

		if @chamber_house and not @chamber_senate
			@committees = @committees.where(:house => 'h')
		elsif @chamber_senate and not @chamber_house
			@committees = @committees.where(:house => 's')		
		end

		@title = "All Committees"

		add_breadcrumb "Committees", ""
	end


	def meetings
		@meetings = CommitteeMeeting.find(:all)

		@title = "Committee Meetings"

		add_breadcrumb "Committees", '/committees'
		add_breadcrumb "Meetings", ""


	end
end
