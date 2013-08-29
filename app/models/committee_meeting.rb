class CommitteeMeeting < ActiveRecord::Base
	set_table_name 'committee_meetings'

	has_many :committee_meeting_bills, :foreign_key => 'committee_meetings_id'
	belongs_to :committee, :foreign_key => 'committee_id'

end
