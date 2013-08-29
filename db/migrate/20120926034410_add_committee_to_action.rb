class AddCommitteeToAction < ActiveRecord::Migration
  def change
  	add_column :actions, :committee, :string
  end
end
