class AddCityToCriticisms < ActiveRecord::Migration
  def change
    add_column :criticisms, :city, :string
  end
end
