class AddToggledStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :toggled_status, :boolean,:default =>false
  end
end
