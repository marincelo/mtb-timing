class AddPointsToRaceResults < ActiveRecord::Migration[5.0]
  def change
    add_column :race_results, :points, :integer
  end
end
