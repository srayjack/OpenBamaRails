class LobbyistRegistration < ActiveRecord::Base
	set_table_name 'lobbyist_registrations'
	belongs_to :lobbyist
end
