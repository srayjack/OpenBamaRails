class LobbyistClient < ActiveRecord::Base
	set_table_name 'lobbyist_client'
	default_scope :order => 'date_added,inactive_date'
	belongs_to :client
	belongs_to :lobbyist
end
