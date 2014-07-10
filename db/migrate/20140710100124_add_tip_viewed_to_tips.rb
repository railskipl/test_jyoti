class AddTipViewedToTips < ActiveRecord::Migration
  def change
    add_column :tips, :tip_viewed, :integer, :default => 0
    add_column :tips, :tip_prediction, :integer, :default => 0
  end
end
