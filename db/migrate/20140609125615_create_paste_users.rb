class CreatePasteUsers < ActiveRecord::Migration
  def change
    create_table :paste_users do |t|
      t.integer :user_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
