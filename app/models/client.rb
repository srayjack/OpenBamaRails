class Client < ActiveRecord::Base
	default_scope :order => 'display_name'
	has_many :lobbyist_clients
	has_many :lobbyists, :through => :lobbyist_clients	
end
