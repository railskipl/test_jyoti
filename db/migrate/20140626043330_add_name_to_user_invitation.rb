class AddNameToUserInvitation < ActiveRecord::Migration
  def change
    add_column :user_invitations, :name, :string
  end
end
