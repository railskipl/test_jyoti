class CreateUserInvitations < ActiveRecord::Migration
  def change
    create_table :user_invitations do |t|
      t.integer :paste_user_id
      t.string :email
      t.boolean :invite_for_feedback
      t.boolean :invite_for_curiosity
      t.string :opinion_value
      t.integer :user_id

      t.timestamps
    end
  end
end
