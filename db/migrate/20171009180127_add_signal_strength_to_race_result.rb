class AddSignalStrengthToRaceResult < ActiveRecord::Migration[5.1]
  def change
    add_column :race_results, :signal_strength, :integer
  end
end
