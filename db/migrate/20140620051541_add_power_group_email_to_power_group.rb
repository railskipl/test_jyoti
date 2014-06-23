class AddPowerGroupEmailToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :power_group_eamil, :string
  end
end
