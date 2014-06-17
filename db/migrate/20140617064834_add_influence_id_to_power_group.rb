class AddInfluenceIdToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :influence_id, :integer
  end
end
