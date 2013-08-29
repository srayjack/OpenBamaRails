class AddCommentsDisabledToBlogPosts < ActiveRecord::Migration
  def change
	add_column :blog_posts, :comments_disabled, :boolean
  end
end
