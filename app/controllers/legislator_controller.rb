class LegislatorController < ApplicationController
  def index
	require 'rss'
	require 'uri'

	@id = params[:id]

	@rating = PersonRating.where(:visitors_id => @visitor_id).where(:person_id => @id).first
	
	
	if @rating
		@visitor_rating = @rating.rating
	else
		@visitor_rating = 0
	end

	if not @visitor_rating
		@visitor_rating = 0
	end

	@legislator_rating = PersonRating.where(:person_id => @id).average(:rating)
	
	if not @legislator_rating
		@legislator_rating = 0
	end

	cookies[:visitor] = PageViewProcess.process_page_view('person', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])
	
	@visitor_id = cookies[:visitor]


	@current_session = AppConfiguration.where(:name => 'current_session').first
	@legislator = Person.find(@id)
	@sponsored_bills = Bill.where(:session_identifier => @current_session.value).where(:sponsor_id => @id).order('introduced desc')
	@cosponsored_bills = Bill.where(:session_identifier => @current_session.value).joins(:bill_cosponsors).where('bills_cosponsors.person_id' => @id)
	@title = @legislator.full_name + ' [' + @legislator.party + '-' + @legislator.district + ']'
	@description = "Detail for Alabama legislator " + @title

	add_breadcrumb "Legislators", "/legislators"

	if @legislator.title == "Sen."
		add_breadcrumb "Senate", "/legislators/index?chambers%5B%5D=senate"
	elsif @legislator.title == "Rep."
		add_breadcrumb "House", "/legislators/index?chambers%5B%5D=house"
	end

	add_breadcrumb @title, ""

	#Total Vote Stats
	@total_yes_votes = Vote.where(:person_id => @id).where(:vote => 'Y').count
	@total_no_votes = Vote.where(:person_id => @id).where(:vote => 'N').count
	@total_not_voting = Vote.where(:person_id => @id).where("vote != 'Y'").where("vote != 'N'").count
	@total_votes = Vote.where(:person_id => @id).count
	
	if @total_votes and @total_votes > 0
		@yes_percent = ((Float(@total_yes_votes) / @total_votes) * 100).round
		@no_percent = ((Float(@total_no_votes) / @total_votes) * 100).round
		@not_percent = ((Float(@total_not_voting) / @total_votes) * 100).round
	else
		@yes_percent = 0
		@no_percent = 0
		@not_percent = 0
	end


	@where = 'v.person_id = ?'.sub("?", @id.to_s)


	#Same Party Vote Stats
	@total_same_yes_votes = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote = 'Y'
						and p1.party = p.party")['rec_count']
	@total_same_no_votes = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote = 'N'
						and p1.party = p.party")['rec_count']
	@total_same_not_voting = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote != 'N' and vote != 'Y' 
						and p1.party = p.party")['rec_count']

	@total_votes = @total_same_yes_votes + @total_same_no_votes + @total_same_not_voting

	if @total_votes and @total_votes > 0
		@same_party_yes_percent = ((Float(@total_same_yes_votes) / @total_votes) * 100).round
		@same_party_no_percent = ((Float(@total_same_no_votes) / @total_votes) * 100).round
		@same_party_not_percent = ((Float(@total_same_not_voting) / @total_votes) * 100).round
	else
		@same_party_yes_percent = 0
		@same_party_no_percent = 0
		@same_party_not_percent = 0
	end

	#Not Same Party Vote Stats
	@total_not_same_yes_votes = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote = 'Y'
						and p1.party != p.party")['rec_count']
	@total_not_same_no_votes = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote = 'N'
						and p1.party != p.party")['rec_count']
	@total_not_same_not_voting = ActiveRecord::Base.connection.select_one("select count(*) as rec_count
						from roll_call_votes v
						inner join roll_calls r on r.id = v.roll_call_id
						inner join bills b on b.id = r.bill_id
						inner join people p on p.id = b.sponsor_id
						inner join people p1 on p1.id = v.person_id
						where " + @where + " 
						and vote != 'N' and vote != 'Y' 
						and p1.party != p.party")['rec_count']


	@total_votes = @total_not_same_yes_votes + @total_not_same_no_votes + @total_not_same_not_voting

	if @total_votes and @total_votes > 0
		@not_same_party_yes_percent = ((Float(@total_not_same_yes_votes) / @total_votes) * 100).round
		@not_same_party_no_percent = ((Float(@total_not_same_no_votes) / @total_votes) * 100).round
		@not_same_party_not_percent = ((Float(@total_not_same_not_voting) / @total_votes) * 100).round
	else
		@not_same_party_yes_percent = 0
		@not_same_party_no_percent = 0
		@not_same_party_not_percent = 0
	end


	if @legislator.title == 'Sen.'
		@long_title = 'Senator'
	else
		@long_title = 'Representative'
	end

	#@rss_url = 'http://blogsearch.google.com/blogsearch_feeds?as_q=&safe=active&q=%22' + @legislator.firstname + '+' + @legislator.lastname + '%22+' + @legislator.title + '+OR+' + @long_title + '&ie=utf-8&num=10&output=rss'

	@rss_url = 'https://www.google.com/search?q=%22' + URI.escape(@legislator.full_name) + '%22&ie=utf-8&tbm=blg&output=rss&safe=active'

	#@rss_string = open(@rss_url).read
	@rss = RSS::Parser.parse(open(@rss_url).read.force_encoding("ISO-8859-1").encode("utf-8", replace: nil), false)
	#@rss_url = 'https://news.google.com/news/feeds?q=%22' + @legislator.firstname + '%20' + @legislator.lastname + '%22%20' + @legislator.title + '%20OR%20' + @long_title + '&hl=en&prmd=imvns&bav=on.2,or.r_gc.r_pw.r_cp.r_qf.,cf.osb&biw=1920&bih=994&um=1&ie=UTF-8&output=rss'
	#@rss_news = RSS::Parser.parse(open(@rss_url).read.force_encoding("ISO-8859-1").encode("utf-8", replace: nil), false)

	@google_blog_url = 'https://www.google.com/search?q=%22' + URI.escape(@legislator.full_name) + '%22&ie=utf-8&tbm=blg'
	
	@base_image_url = AppConfiguration.where(:name => 'base_image_url').first.value

	if @legislator.title == 'Sen.'
		@district = District.where(:district_number => @legislator.district).where(:type => 's').first
	else
		@district = District.where(:district_number => @legislator.district).where(:type => 'h').first
	end

	@committees = CommitteePerson.where(:person_id => @legislator.id).where(:session_identifier => @current_session.value).sort_by{|p| p[:roll_rank]}
	


  end

  def rate
	@id = params[:id]
	@visitor_id = params[:visitor]
	#cookies[:visitor] = PageViewProcess.process_page_view('bill', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])

	@rating = params[:visitor_rating]

	@person_rating = PersonRating.where(:visitors_id => Integer(@visitor_id)).where(:person_id => @id).first

	if @person_rating
		@person_rating.rating = @rating
		@person_rating.updated_on = Date.today
		@person_rating.save
	else
		@person_rating = PersonRating.new(:person_id => @id, :rating => @rating, :created_on => Date.today, :visitors_id => Integer(@visitor_id))
		@person_rating.save
	end


	redirect_to '/legislator/' + @id

  end

  def votes
  	@session_identifier = params[:session]
	@id = params[:id]
	if not @session_identifier
		@current_session = AppConfiguration.where(:name => 'current_session').first
		@session_identifier = @current_session.value
	end

	@legislator = Person.find(@id)

	@sessions = Session.where(:enabled => 1).order('session_identifier DESC')

	#@session_identifier = '1060'
	@votes = RollCall.joins(:bill).joins(:votes).joins(:action).select('roll_calls.bill_id as bill_id,roll_calls.result as outcome, roll_calls.id as id,bills.bill_type as bill_type,bills.description as description,bills.number as number,case roll_call_votes.vote when "Y" Then "Yes" when "A" Then "Abstain" when "N" Then "No" when "P" Then "Pass" else "" end as person_vote,roll_calls.vote_date as vote_date, actions.action_text').where('bills.session_identifier = ?',@session_identifier).where('roll_call_votes.person_id = ?',@id)
	@title = "Vote History for " + @legislator.full_name

	add_breadcrumb "Legislators", "/legislators"

	add_breadcrumb @legislator.full_name, "/legislator/" + @id

	add_breadcrumb @title, request.fullpath

  end

end
