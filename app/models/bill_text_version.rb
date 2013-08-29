class BillTextVersion < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_text_versions'

  belongs_to	:bill, :foreign_key => 'bill_id'
  has_many	:bill_text_version_contents, :foreign_key => 'bills_text_versions_id'

end
