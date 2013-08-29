class BillStatus < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_statuses'
  belongs_to	:bill, :foreign_key => 'bill_id'
  default_scope :order => 'status_date DESC'


  def pretty_status
	case bill_status
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
		bill_status
	end
  end
end
