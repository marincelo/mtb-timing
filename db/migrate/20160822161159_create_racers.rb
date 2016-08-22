class CreateRacers < ActiveRecord::Migration[5.0]
  def change
    create_table :racers do |t|
      t.string :first_name
      t.string :last_name
      t.integer :year_of_birth
      t.integer :gender
      t.string :email
      t.string :phone_number
      t.integer :start_number

      t.timestamps
    end
  end
end
