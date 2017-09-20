class CreateStartNumbers < ActiveRecord::Migration[5.0]
  def change
    create_table :start_numbers do |t|
      t.integer :value
      t.string :tag_id
      t.integer :signal_strength
      t.belongs_to :racer, foreign_key: true

      t.timestamps
    end
  end
end
