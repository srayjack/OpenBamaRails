class HomeController < ApplicationController
  def index
	@senator_count = Person.where(:isActive => 1, :title => 'Sen.').count()
	@rep_count = Person.where(:isActive => 1, :title => 'Rep.').count()
	
	@house_committees = Committee.where("IFNULL(isSubcommittee, 0) <> 1").where(:house => 'h').count()
	@senate_committees = Committee.where("IFNULL(isSubcommittee, 0) <> 1").where(:house => 's').count()

	@app_config = AppConfiguration.where(:name => 'current_session').first
	@session_identifier = @app_config.value

	@in_session = AppConfiguration.where(:name => 'legislature.currently_in_session').first.value

	@current_session = Session.find(@session_identifier)

	@bill_count_house = Bill.includes( :bill_statuses ).where(:session_identifier => @session_identifier).where("bills.bill_type like 'h%'").count()
	@bill_count_senate = Bill.includes( :bill_statuses ).where(:session_identifier => @session_identifier).where("bills.bill_type like 's%'").count()


	@lobbyist_count = Lobbyist.where(:active => 1 ).count()
	@client_count = Client.includes(:lobbyist_clients).where('lobbyist_client.is_active = 1').count()

	@posts = BlogPost.where(:status_id => 2).limit(5)
	
	@post = @posts[0]
	@posts = @posts[1..4]
	
	@most_viewed_bill = PageView.select('bill_id, count(*) as page_views').joins(:bill).where('bills.session_identifier = ?',@session_identifier).where('bill_id > 0').where('bill_id is not null').group(:bill_id).first
	
	#@most_viewed_bill = Bill.find(@most_viewed_bill_stats.bill_id)

	@most_viewed_senator = PageView.select('person_id, count(*) as page_views').joins(:person).where('person_id > 0').where('person_id is not null').where('people.title = "sen."').group(:person_id).first

	@most_viewed_rep = PageView.select('person_id, count(*) as page_views').joins(:person).where('person_id > 0').where('person_id is not null').where('people.title = "rep."').group(:person_id).first

	@base_image_url = AppConfiguration.where(:name => 'base_image_url').first.value

	@bill_user_votes = BillVote.joins(:bill).select('DISTINCT bill_id,bills.bill_type,bills.number').where('bills.session_identifier = ?',@session_identifier).order('bill_votes.vote_date desc').limit(5)

	@meetings = CommitteeMeeting.limit(5)

	@rated_legislators = PersonRating.joins(:person).order('updated_on desc').limit(5)

	@title = 'Welcome to OpenBama'

	@description = "Welcome to OpenBama! OpenBama provides the citizens of Alabama a tool to track the activities of our elected officials in Montgomery."

  end
end
