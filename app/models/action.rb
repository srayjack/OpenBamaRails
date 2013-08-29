class Action < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to	:bill, :foreign_key => 'bill_id'
  default_scope	:conditions => {:deleteddate => nil}, :order => 'action_date asc, is_bir, location'
#  has_one	:bill_amendment
  belongs_to	:bill_amendment, :foreign_key => 'amendment_id'
  has_one	:roll_call
  
  def actor
    if location == 'h'
      "House"
    elsif location == 's'
      "Senate"
    else
      ""
    end
  end

  def pretty_status
	case action_type
	when 'introduced'
		"Introduced"
	when 'calendar2'
		"Calendar Second House"	
	when 'calendar1'
		"Calendar First House"
	when 'passvote1'
		"Passed First House"
	when 'passvote2'
		"Passed Second House"
	when 'enacted'
		"Became Law"
	when 'togovernor'
		"Sent to Governor"
	when 'failvote1'
		"Failed in First House"
	when 'failvote2'
		"Failed in Second House"
	when 'veto'
		"Vetoed"	
	else
		action_type
	end
  end
end
