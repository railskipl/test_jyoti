class AddUserIdToSponser < ActiveRecord::Migration
  def change
    add_column :sponsers, :user_id, :integer
  end
end
