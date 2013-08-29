class CreatePagesTable < ActiveRecord::Migration
  def up
    create_table :pages do |t|
      t.string :title
      t.string :uri_short_name
      t.text :content
      t.boolean :comments_enabled
 
      t.timestamps
    end
  end
 
  def down
    drop_table :products
  end
end
