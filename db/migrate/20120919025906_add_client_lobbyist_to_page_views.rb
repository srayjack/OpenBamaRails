class AddClientLobbyistToPageViews < ActiveRecord::Migration
  def change
	add_column :page_views, :client_id, :integer
	add_column :page_views, :lobbyist_id, :integer
  end
end
