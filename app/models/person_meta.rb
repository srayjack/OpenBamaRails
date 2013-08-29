class PersonMeta < ActiveRecord::Base
	set_table_name 'people_meta_data'
	belongs_to	:person
end
