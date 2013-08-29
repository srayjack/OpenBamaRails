class BillSubject < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_subjects'  
  belongs_to	:bill
  belongs_to	:subject
end
