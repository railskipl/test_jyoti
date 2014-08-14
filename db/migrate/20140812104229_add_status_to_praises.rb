class AddStatusToPraises < ActiveRecord::Migration
  def change
    add_column :praises, :status, :boolean, :default => false
  end
end
