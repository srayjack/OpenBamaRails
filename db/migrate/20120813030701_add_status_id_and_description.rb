class AddStatusIdAndDescription < ActiveRecord::Migration
  def change
	add_column :blog_posts, :status_id, :integer	
	add_column :blog_posts, :description, :text
  end
end
