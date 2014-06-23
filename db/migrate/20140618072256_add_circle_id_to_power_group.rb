class AddCircleIdToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :circle_id, :integer
  end
end
