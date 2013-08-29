class AddBlogIdToPageViews < ActiveRecord::Migration
  def change
	add_column :page_views, :blog_post_id, :integer
  end
end
