class CreateReactions < ActiveRecord::Migration
  def change
    create_table :reactions do |t|
      t.text :reaction_comment
      t.integer :praise_id
      t.integer :criticism_id
      t.integer :general_id
      t.integer :provider_user_id
      t.integer :reciver_user_id
      t.integer :response_id

      t.timestamps
    end
  end
end
