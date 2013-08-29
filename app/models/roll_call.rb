class RollCall < ActiveRecord::Base
  # attr_accessible :title, :body
	set_table_name 'roll_calls'
	belongs_to	:bill, :foreign_key => 'bill_id'
	has_many 	:votes, :foreign_key => 'roll_call_id'
	has_one		:action, :foreign_key => 'roll_call_id'
	
	def chamber
		if location == 'h'
			'House'
		else
			'Senate'
		end
	end

end
