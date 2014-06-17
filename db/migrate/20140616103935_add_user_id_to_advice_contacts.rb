class AddUserIdToAdviceContacts < ActiveRecord::Migration
  def change
    add_column :advice_contacts, :user_id, :integer
  end
end
