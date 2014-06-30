class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.string :email
      t.string :praise
      t.string :criticism
      t.string :helpful
      t.integer :user_id

      t.timestamps
    end
  end
end
