class Bill < ActiveRecord::Base
  attr_accessible :current_text
  default_scope	:conditions => {:disabled => 0}
  has_many	:versions, :foreign_key => 'bill_id'
  has_many	:bill_statuses, :foreign_key => 'bill_id'
  has_many	:actions, :foreign_key => 'bill_id'
  has_many	:bill_subjects
  has_many	:subjects, :through => :bill_subjects
  belongs_to	:person, :foreign_key => 'sponsor_id'
  has_many	:bill_cosponsors
  has_many	:people, :through => :bill_cosponsors
  belongs_to	:session, :foreign_key => 'session_identifier'
  has_many	:bill_tags, :foreign_key => 'bill_id'
  has_many	:tags, :through => :bill_tags
  has_many	:bill_votes, :foreign_key => 'bill_id'
  has_many	:bill_amendments, :foreign_key => 'bill_id'
  has_many	:roll_calls, :foreign_key => 'bill_id'
  has_many	:committees, :through => :bill_committee
  has_many	:bill_committees
  has_many	:bill_text_versions
  has_many	:bill_text_version_contents, :through => :bill_text_versions
  has_many	:page_views, :foreign_key => 'bill_id'

  def latest_status
	 return BillStatus.where(:bill_id => id).first
  end

  def current_status
   return BillStatus.where(:bill_id => id).first.pretty_status
  end

  def user_support_rating
    @supporter_count = BillVote.where(:bill_id => id).where(:support => 1).count
    @opposition_count = BillVote.where(:bill_id => id).where(:support => 0).count
    @total_votes = @supporter_count + @opposition_count
    if @total_votes > 0
      return ((@supporter_count / @total_votes) * 100).to_s +  '% support'
    else
      return 'Not rated yet'
    end
  end

  def sponsor_name
    return Person.find(sponsor_id).full_name
  end

  include Tanker

  tankit 'my_index' do

  end
end
