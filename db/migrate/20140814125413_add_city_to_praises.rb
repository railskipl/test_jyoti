class AddCityToPraises < ActiveRecord::Migration
  def change
    add_column :praises, :city, :string
  end
end
