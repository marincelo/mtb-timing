class AddBirthInfoToRacers < ActiveRecord::Migration[5.0]
  def change
    add_column :racers, :day_of_birth, :integer
    add_column :racers, :month_of_birth, :integer
  end
end
