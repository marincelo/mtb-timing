class AddRacerToClub < ActiveRecord::Migration[5.0]
  def change
    add_reference :racers, :club, foreign_key: true
  end
end
