class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :response_comment
      t.integer :praise_id
      t.integer :criticism_id
      t.integer :general_id
      t.integer :response_user_id
      t.integer :provider_user_id

      t.timestamps
    end
  end
end
