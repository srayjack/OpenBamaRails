class AddVisitorsIdToBillVotes < ActiveRecord::Migration
  def change
    add_column "bill_votes", :visitors_id, :integer
  end
end

