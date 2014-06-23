class AddCustomFactorToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :custom_factor, :string
  end
end
