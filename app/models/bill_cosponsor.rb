class BillCosponsor < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_cosponsors'  
  belongs_to	:bill
  belongs_to	:person
end
