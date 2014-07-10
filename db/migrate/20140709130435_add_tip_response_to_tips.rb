class AddTipResponseToTips < ActiveRecord::Migration
  def change
    add_column :tips, :tip_accept, :integer, :default => 0
    add_column :tips, :tip_reject, :integer, :default => 0
  end
end
