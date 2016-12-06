class AddDescriptionUrlToRaces < ActiveRecord::Migration[5.0]
  def change
    add_column :races, :description_url, :string
  end
end
