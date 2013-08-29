class RenameCommentsDisabledToCommentsEnabled < ActiveRecord::Migration
  def change
    change_table :blog_posts do |t|
      t.rename :comments_disabled, :comments_enabled
    end
  end
end
