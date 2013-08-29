class Vote < ActiveRecord::Base
  # attr_accessible :title, :body
	set_table_name 'roll_call_votes'
	belongs_to	:roll_call
	belongs_to	:person
	default_scope	:order => 'vote'
end
