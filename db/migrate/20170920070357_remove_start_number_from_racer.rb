class RemoveStartNumberFromRacer < ActiveRecord::Migration[5.0]
  def change
    remove_column :racers, :start_number
  end
end
