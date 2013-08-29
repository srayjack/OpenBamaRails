class Version < ActiveRecord::Base
  set_table_name 'bills_text_versions'
  belongs_to	:bill, :foreign_key => 'bill_id'
  default_scope :order => 'version_date'

  def version_type_description
	if version_type == 'int'
		'Introduced'
	elsif version_type == 'eng'
		'Engrosed'
	elsif version_type == 'enr'
		'Enrolled'
	end
  end
end
