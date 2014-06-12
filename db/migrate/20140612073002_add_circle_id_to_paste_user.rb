class AddCircleIdToPasteUser < ActiveRecord::Migration
  def change
    add_column :paste_users, :circle_id, :integer
  end
end
