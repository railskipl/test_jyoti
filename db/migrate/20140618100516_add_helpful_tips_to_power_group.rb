class AddHelpfulTipsToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :helpful_tips, :text
  end
end
