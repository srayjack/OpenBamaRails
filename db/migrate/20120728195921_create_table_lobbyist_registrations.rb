class CreateTableLobbyistRegistrations < ActiveRecord::Migration
  def self.up
    create_table :lobbyist_registrations, :force => true do |t|
      t.integer   "lobbyist_id"
      t.datetime   "date_added"
      t.boolean   "is_active"
      t.integer   "year_registered"
    end
  end
  
  def self.down
    drop_table 'lobbyist_registrations'
  end
end
