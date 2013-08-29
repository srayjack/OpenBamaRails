class Session < ActiveRecord::Base
  set_table_name 'session'
  set_primary_key 'session_identifier'
  default_scope :conditions => {:enabled => 1},:order => 'start_date desc'
end
