class AddStatusToGenerals < ActiveRecord::Migration
  def change
    add_column :generals, :status, :boolean, :default => false
  end
end
