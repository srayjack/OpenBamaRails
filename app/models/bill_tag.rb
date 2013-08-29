class BillTag < ActiveRecord::Base
  set_table_name 'bills_tags'
  belongs_to :bill, :foreign_key => 'bill_id'
  belongs_to :tag, :foreign_key => 'tag_id'
  attr_accessible :bill_id
  attr_accessible :tag_id
end
