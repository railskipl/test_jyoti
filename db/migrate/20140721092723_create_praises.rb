class CreatePraises < ActiveRecord::Migration
  def change
    create_table :praises do |t|
      t.text :praise_comment
      t.integer :provider_user_id
      t.string :email
      t.integer :tip_accept, :default => 0
      t.integer :tip_reject, :default => 0
      t.text :feedback
      t.string :comment_quality
      t.integer :tip_viewed, :default => 0
      t.integer :tip_prediction, :default => 0
      t.string :typee 

      t.timestamps
    end
  end
end
