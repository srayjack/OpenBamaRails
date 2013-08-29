class AddIsAgencyToLobbyists < ActiveRecord::Migration
  def change
	add_column :lobbyists, :is_agency, :boolean
  end
end
