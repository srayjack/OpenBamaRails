class AddCurrentTextToBills < ActiveRecord::Migration
  def change
  	add_column :bills, :current_text, :text
  end
end
