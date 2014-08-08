class AddUserIdToStatusChecks < ActiveRecord::Migration
  def change
    add_column :status_checks, :user_id, :integer
  end
end
