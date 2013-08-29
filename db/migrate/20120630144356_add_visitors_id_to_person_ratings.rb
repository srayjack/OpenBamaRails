class AddVisitorsIdToPersonRatings < ActiveRecord::Migration
  def change
    add_column "person_ratings", :visitors_id, :integer
  end
end
