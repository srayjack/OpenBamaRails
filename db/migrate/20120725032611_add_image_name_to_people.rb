class AddImageNameToPeople < ActiveRecord::Migration
  def change
    add_column :people, :image_name, :string
  end
end
