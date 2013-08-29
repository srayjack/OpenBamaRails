class Committee < ActiveRecord::Base

	default_scope	:conditions => {:active => 1}, :order => 'committee_name'
	has_many	:people, :through => :committee_people
	has_many	:committee_people
	has_many	:bills, :through => :bill_committees
	has_many	:bill_committees
	has_many	:committee_meetings

	def subcommittees
		return Committee.where("committee_name = ? and isSubcommittee = 1", committee_name)
	end
end
