class CreateCommitteeRoleRanks < ActiveRecord::Migration
  def up
    create_table :committee_role_ranks do |t|
      t.string :role
      t.integer :rank
 
      t.timestamps
    end
  end
 
  def down
    drop_table :committee_role_ranks
  end
end
