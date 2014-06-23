class AddPraiseTipsToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :praise_tips, :text
  end
end
