class AddPointsToClubs < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :points, :integer, default: 0
  end
end
