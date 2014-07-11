class AddCircleNameToPowerGroups < ActiveRecord::Migration
  def change
    add_column :power_groups, :circle_name, :string
  end
end
