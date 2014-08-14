class AddStatusToCriticisms < ActiveRecord::Migration
  def change
    add_column :criticisms, :status, :boolean, :default => false
  end
end
