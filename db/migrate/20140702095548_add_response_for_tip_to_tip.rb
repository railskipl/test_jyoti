class AddResponseForTipToTip < ActiveRecord::Migration
  def change
    add_column :tips, :response_for_tip, :string
  end
end
