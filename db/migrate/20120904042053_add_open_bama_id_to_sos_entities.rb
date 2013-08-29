class AddOpenBamaIdToSosEntities < ActiveRecord::Migration
  def change
	add_column :sos_entities, :openbama_id, :integer
  end
end
