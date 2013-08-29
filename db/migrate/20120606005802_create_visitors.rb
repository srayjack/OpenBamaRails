class CreateVisitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|

      t.datetime "date_visited"
    end
  end

end
