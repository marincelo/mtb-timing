class AddUserToRacer < ActiveRecord::Migration[5.0]
  def change
    add_reference :racers, :user, foreign_key: true
  end
end
