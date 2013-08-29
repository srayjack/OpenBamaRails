class AddVisitorsIdToPageViews < ActiveRecord::Migration
  def change
    add_column "page_views", :visitors_id, :integer
  end
end
