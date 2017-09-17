class AddUciIdToRacer < ActiveRecord::Migration[5.0]
  def change
    add_column :racers, :uci_id, :string
  end
end
