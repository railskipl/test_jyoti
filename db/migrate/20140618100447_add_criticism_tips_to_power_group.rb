class AddCriticismTipsToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :criticism_tips, :text
  end
end
