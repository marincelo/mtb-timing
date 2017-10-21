class AddLapDelayToRace < ActiveRecord::Migration[5.1]
  def change
    add_column :races, :lap_delay, :integer, default: 60
  end
end
