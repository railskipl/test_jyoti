class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.text :feedback_comment
      t.integer :praise_id
      t.integer :criticism_id
      t.integer :general_id
      t.integer :provider_user_id
      t.string :recipient_email
      t.string :comment_quality

      t.timestamps
    end
  end
end
