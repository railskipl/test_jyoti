class AddCircleIdToUserInvitation < ActiveRecord::Migration
  def change
    add_column :user_invitations, :circle_id, :integer
  end
end
