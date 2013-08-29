class BillController < ApplicationController

  
  def detail	

	@id = params[:id]
	@session = params[:session]
	@bill_type = params[:bill_type]
	@bill_number = params[:number]

	if @session and @bill_type and @bill_number
		@bill = Bill.where(:session_identifier => @session, :bill_type => @bill_type, :number => @bill_number).first
	else
		@bill = Bill.find(@id)
	end

	@supporter_count = BillVote.where(:bill_id => @bill.id).where(:support => 1).count
	@opposition_count = BillVote.where(:bill_id => @bill.id).where(:support => 0).count
	
	@tags = @bill.tags

	cookies[:visitor] = PageViewProcess.process_page_view('bill', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])


	@seven_days_ago = Date.today - 7
	@total_views = PageView.where(:bill_id => @id).count
	@total_views_7 = PageView.where(:bill_id => @id).where('viewed_on > ?', @seven_days_ago).count
	@total_views_today = PageView.where(:bill_id => @id).where('viewed_on > ?', Date.today - 1).count

	@intro, @pass1, @pass2, @law, @sent, @failed1, @failed2, @veto = false, false, false, false, false, false, false, false
	@bill.bill_statuses.each do |s|
		if s.pretty_status == 'Introduced'
			@intro = true
			@intro_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Passed First House'
			@pass1 = true
			@pass1_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Passed Second House'
			@pass2 = true
			@pass2_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Became Law'
			@law = true
			@law_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Sent to Governor'
			@sent = true
			@sent_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Failed in First House'
			@failed1 = true
			@failed1_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Failed in Second House'
			@failed2 = true
			@failed2_date = s.status_date.strftime('%m/%d/%Y')
		elsif s.pretty_status == 'Vetoed' or s.pretty_status == 'vetoed'
			@veto = true
			@veto_date = s.status_date.strftime('%m/%d/%Y')
		end
	end

	@meetings = CommitteeMeeting.joins(:committee_meeting_bills).where('committee_meetings_bills.bill_id' => @bill.id)

	@title = @bill.session.session_label + ' | Detail for ' + @bill.bill_type.upcase + @bill.number.to_s

	@description = "Bill detail for " + @bill.bill_type.upcase + @bill.number.to_s + " - " + @bill.session.session_label

	add_breadcrumb "Bills", "/bills"

	add_breadcrumb @bill.session.session_label , "/bills/index?session=" + @bill.session.session_identifier

	add_breadcrumb @bill.bill_type.upcase + @bill.number.to_s, ""

	@base_pdf_url = AppConfiguration.where(:name => 'base_pdf_url').first.value
	
  end



  def fetch_url(url)
    r = Net::HTTP.get_response( URI.parse( url ) )
    if r.is_a? Net::HTTPSuccess
      r.body.to_s.force_encoding("UTF-8")
    else
      nil
    end
  end

  def text
	cookies[:visitor] = PageViewProcess.process_page_view('bill', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])

	@base_pdf_url = AppConfiguration.where(:name => 'base_pdf_url').first.value

	@id = params[:id]

	@bill = Bill.find(@id)

	@versions = @bill.versions
	
	if @bill.bill_type.count('r') > 0
		@text = fetch_url @bill.session.bill_html_repository + 'resolutions/' + @bill.bill_type + @bill.number.to_s + '.htm'
	else 
		@text = fetch_url @bill.session.bill_html_repository + 'bills/' + @bill.bill_type + @bill.number.to_s + '.htm'	
	end

	if not @text
		@text = 'The text of this bill is not available yet.'
	end

	@al_code_base_url = AppConfiguration.where(:name => 'base_code_of_al_url').first.value

	@replace_text = '<a target="_blank" href="' + @al_code_base_url + '\1.htm">\1</a>'

	@text = @text.force_encoding("ISO-8859-1").encode("utf-8", replace: nil).gsub /([0-9]+[A-Za-z]*\-[0-9]+[A-Za-z]*\-[0-9]+[A-Za-z]*\.?[0-9]*)/ , @replace_text

	@text = @text.gsub(/\.\.htm/,'.htm')

	if @text != @bill.current_text
		@bill.current_text = @text
		@bill.save
	end


	@bill_detail_title = @bill.session.session_label + ' | Detail for ' + @bill.bill_type.upcase + @bill.number.to_s

	@title = @bill.session.session_label + ' | Text for ' + @bill.bill_type.upcase + @bill.number.to_s

	@description = "Text of " + @bill.bill_type.upcase + @bill.number.to_s + " - " + @bill.session.session_label

	add_breadcrumb "Bills", "/bills"

	add_breadcrumb @bill.session.session_label , "/bills/index?session=" + @bill.session.session_identifier

	add_breadcrumb @bill.bill_type.upcase + @bill.number.to_s, "/bill/" + @bill.id.to_s

	add_breadcrumb "Text", ""

	@al_code_url = AppConfiguration.where(:name => 'link_to_al_code').first.value

  end

  def add_tag
	#@tag_name = request.raw_post.split(/&/).grep(/tag_name=/).first.split(/=/).last
	@tag_text = params[:tag_text]

	@bill_id = params[:id]

	@tag = Tag.where(:tag_name => @tag_text.downcase).first
	
	if @tag
		@bill_tag = BillTag.where(:bill_id => @bill_id).where(:tag_id => @tag.id).first

		if not @bill_tag
			@bill_tag = BillTag.new(:bill_id => @bill_id, :tag_id => @tag.id)

			@bill_tag.save
		end
	else
		@new_tag = Tag.new(:tag_name => @tag_text.downcase)

		if @new_tag.save
			@bill_tag = BillTag.new(:bill_id => @bill_id, :tag_id => @new_tag.id)

			@bill_tag.save
		end
	end


	redirect_to '/bill/' + @bill_id
  end

  def vote_yes
	@id = params[:id]

	cookies[:visitor] = PageViewProcess.process_page_view('bill', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])

	@visitor_id = cookies[:visitor]

	
	@bill_vote = BillVote.where(:visitors_id => Integer(@visitor_id)).where(:bill_id => @id).first

	if @bill_vote
		@bill_vote.support = 1

		@bill_vote.vote_date = Date.today

		@bill_vote.save
	else
		@bill_vote = BillVote.new(:bill_id => @id, :support => 1, :vote_date => Date.today, :visitors_id => Integer(@visitor_id))
		
		@bill_vote.save
	end

	redirect_to '/bill/' + @id

  end

  def vote_no
	@id = params[:id]
	cookies[:visitor] = PageViewProcess.process_page_view('bill', @id, cookies[:visitor], request.env["HTTP_USER_AGENT"])
	@visitor_id = cookies[:visitor]

	
	@bill_vote = BillVote.where(:visitors_id => Integer(@visitor_id)).where(:bill_id => @id).first

	if @bill_vote
		@bill_vote.support = 0
		@bill_vote.vote_date = Date.today
		@bill_vote.save
	else
		@bill_vote = BillVote.new(:bill_id => @id, :support => 0, :vote_date => Date.today, :visitors_id => Integer(@visitor_id))
		@bill_vote.save
	end


	redirect_to '/bill/' + @id
  end
end
