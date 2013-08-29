class BillVote < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :support
  attr_accessible :vote_date
  attr_accessible :visitors_id
  attr_accessible :bill_id
  set_table_name 'bill_votes'  
  belongs_to	:bill
end
