class BillAmendment < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_amendments'
  set_inheritance_column :ruby_type
  #belongs_to :action, :foreign_key => 'amendment_id'
  has_one	:action
  belongs_to	:bill, :foreign_key => 'bill_id'
  default_scope :order => 'amendmentdate'

end
