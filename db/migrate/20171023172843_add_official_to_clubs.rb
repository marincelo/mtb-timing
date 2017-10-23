class AddOfficialToClubs < ActiveRecord::Migration[5.1]
  def change
    add_column :clubs, :official, :boolean, default: false
  end
end
