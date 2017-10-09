class AddSignalStrengthToRaceResult < ActiveRecord::Migration[5.1]
  def change
    add_column :race_results, :signal_strength, :integer, default: -1000
  end
end
