class AddIsActiveToLobbyistClient < ActiveRecord::Migration
  def change
	add_column 'lobbyist_client', :is_active, :boolean
	add_column 'lobbyist_client', :year_registered, :integer
  end
end
