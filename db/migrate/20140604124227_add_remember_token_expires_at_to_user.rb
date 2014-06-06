class AddRememberTokenExpiresAtToUser < ActiveRecord::Migration
  def change
    add_column :users, :remember_token_expires_at, :datetime
  end
end
