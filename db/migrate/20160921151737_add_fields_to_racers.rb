class AddFieldsToRacers < ActiveRecord::Migration[5.0]
  def change
    add_column :racers, :zip_code, :string
    add_column :racers, :town, :string
  end
end
