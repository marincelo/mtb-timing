class CreateRaces < ActiveRecord::Migration[5.0]
  def change
    create_table :races do |t|
      t.string :name
      t.datetime :date
      t.integer :laps
      t.integer :easy_laps

      t.timestamps
    end
  end
end
