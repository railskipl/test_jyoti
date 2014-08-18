class AddCityToGenerals < ActiveRecord::Migration
  def change
    add_column :generals, :city, :string
  end
end
