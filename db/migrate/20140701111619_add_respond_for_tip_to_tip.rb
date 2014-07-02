class AddRespondForTipToTip < ActiveRecord::Migration
  def change
    add_column :tips, :respond_for_tip, :string
  end
end
