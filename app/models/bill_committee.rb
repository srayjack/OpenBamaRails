class BillCommittee < ActiveRecord::Base
  set_table_name 'bills_committees'
  belongs_to :bill
  belongs_to :committee

end
