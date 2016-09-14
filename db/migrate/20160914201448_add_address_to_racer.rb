class AddAddressToRacer < ActiveRecord::Migration[5.0]
  def change
    add_column :racers, :address, :string
  end
end
