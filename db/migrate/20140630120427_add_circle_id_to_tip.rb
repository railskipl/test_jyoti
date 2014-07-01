class AddCircleIdToTip < ActiveRecord::Migration
  def change
    add_column :tips, :circle_id, :integer
    add_column :tips, :name, :string
  end
end
