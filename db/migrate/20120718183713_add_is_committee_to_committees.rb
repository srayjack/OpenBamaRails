class AddIsCommitteeToCommittees < ActiveRecord::Migration
  def change
    add_column :committees, :isCommittee, :boolean
  end
end
