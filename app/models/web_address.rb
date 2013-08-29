class WebAddress < ActiveRecord::Base
	set_table_name 'web_addresses'
	belongs_to	:person
	default_scope	:order => 'web_address_type'
end
