class FixIsCommittee < ActiveRecord::Migration
  def change
	rename_column :committees, :isCommittee, :isSubcommittee
  end

end
