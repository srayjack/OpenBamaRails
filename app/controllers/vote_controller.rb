class VoteController < ApplicationController
  def index
	@id = params[:id]

	cookies[:visitor] = PageViewProcess.process_page_view('roll_call', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])

	@roll_call = RollCall.includes(:votes).includes(:bill).find(@id)
	@yes_votes = Vote.where(:roll_call_id => @id).where('roll_call_votes.vote' => 'Y')
	@no_votes = Vote.where(:roll_call_id => @id).where('roll_call_votes.vote' => 'N')
	@not_votes = Vote.where(:roll_call_id => @id).where('roll_call_votes.vote != ?', 'N').where('roll_call_votes.vote != ?', 'Y')
	@title = @roll_call.bill.bill_type.upcase + @roll_call.bill.number.to_s + ' - ' + @roll_call.action.action_text


	@repub_yes_count = 0
	@dem_yes_count = 0
	@other_yes_count = 0
	
	@total_count = @yes_votes.count

	if @yes_votes.count > 0
		@yes_votes.each do |v|
			if v.person.party == 'Republican'
				@repub_yes_count += 1
			elsif v.person.party == 'Democrat'
				@dem_yes_count += 1
			else
				@other_yes_count += 1
			end
		end
		@repub_yes_percent = ((Float(@repub_yes_count) / @total_count) * 100).round
		@dem_yes_percent = ((Float(@dem_yes_count) / @total_count) * 100).round
		@other_yes_percent = ((Float(@other_yes_count) / @total_count) * 100).round
	end
	

	@repub_no_count = 0
	@dem_no_count = 0
	@other_no_count = 0

	@total_count = @no_votes.count

	if @no_votes.count > 0
		@no_votes.each do |v|
			if v.person.party == 'Republican'
				@repub_no_count += 1
			elsif v.person.party == 'Democrat'
				@dem_no_count += 1
			else
				@other_no_count += 1
			end
		end
		@repub_no_percent = ((Float(@repub_no_count) / @total_count) * 100).round
		@dem_no_percent = ((Float(@dem_no_count) / @total_count) * 100).round
		@other_no_percent = ((Float(@other_no_count) / @total_count) * 100).round
	end


	@repub_not_count = 0
	@dem_not_count = 0
	@other_not_count = 0

	@total_count = @not_votes.count

	if @not_votes.count > 0
		@not_votes.each do |v|
			if v.person.party == 'Republican'
				@repub_not_count += 1
			elsif v.person.party == 'Democrat'
				@dem_not_count += 1
			else
				@other_not_count += 1
			end
		end

		@repub_not_percent = ((Float(@repub_not_count) / @total_count) * 100).round
		@dem_not_percent = ((Float(@dem_not_count) / @total_count) * 100).round
		@other_not_percent = ((Float(@other_not_count) / @total_count) * 100).round
	end

	add_breadcrumb "Votes", "/votes"

	if @roll_call.location == 'h'
		add_breadcrumb "House", "/votes/index?chambers%5B%5D=house&session=" + @roll_call.bill.session_identifier
	elsif @roll_call.location == 's'
		add_breadcrumb "House", "/votes/index?chambers%5B%5D=senate&session=" + @roll_call.bill.session_identifier
	end

	add_breadcrumb @title, ""
  end
end
