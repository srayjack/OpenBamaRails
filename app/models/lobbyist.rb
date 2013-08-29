class Lobbyist < ActiveRecord::Base
	default_scope :order => 'last_name, first_name, middle_name'
	has_many :lobbyist_clients
	has_many :clients, :through => :lobbyist_clients
	has_many :lobbyist_registrations	

	def display_name
		if middle_name and middle_name.length > 0
			@name = last_name + ', ' + first_name + ', ' + middle_name
		else
			@name = last_name + ', ' + first_name
		end

		if not first_name or first_name.length == 0
			@name = last_name
		end
		
		@name.sub "  ", " "
		return @name

	end
end
