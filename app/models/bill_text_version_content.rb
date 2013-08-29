class BillTextVersionContent < ActiveRecord::Base
  # attr_accessible :title, :body
  set_table_name 'bills_text_versions_contents'

  belongs_to	:bill_text_version, :foreign_key => 'bills_text_versions_id'

end
