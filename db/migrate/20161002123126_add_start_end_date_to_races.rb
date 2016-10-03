class AddStartEndDateToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :started_at, :datetime
    add_column :races, :ended_at, :datetime
  end
end
