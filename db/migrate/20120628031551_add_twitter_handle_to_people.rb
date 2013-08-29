class AddTwitterHandleToPeople < ActiveRecord::Migration
  def change
    add_column :people, :twitter_handle, :string
  end
end
