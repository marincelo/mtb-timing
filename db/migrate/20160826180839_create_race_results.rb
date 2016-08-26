class CreateRaceResults < ActiveRecord::Migration[5.0]
  def change
    create_table :race_results do |t|
      t.belongs_to :racer, foreign_key: true
      t.belongs_to :race, foreign_key: true
      t.integer :status
      t.text :lap_times, array: true, default: []

      t.timestamps
    end
  end
end
