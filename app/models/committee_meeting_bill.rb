class CommitteeMeetingBill < ActiveRecord::Base
	set_table_name 'committee_meetings_bills'

	belongs_to :committee_meeting, :foreign_key => 'committee_meetings_id'
	belongs_to :bill, :foreign_key => 'bill_id'

end
