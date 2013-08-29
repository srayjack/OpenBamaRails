class AddSideBarContentToPages < ActiveRecord::Migration
  def change
	add_column :pages, :sidebar_content, :text
  end
end
