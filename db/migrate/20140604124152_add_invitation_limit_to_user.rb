class AddInvitationLimitToUser < ActiveRecord::Migration
  def change
    add_column :users, :invitation_limit, :inteher
  end
end
