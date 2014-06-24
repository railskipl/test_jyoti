class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string  :email
      t.integer :user_id
      t.string :token
      t.boolean :verified
      t.boolean :merged,:default => false
      t.boolean :primary

      t.timestamps
    end
  end
end
