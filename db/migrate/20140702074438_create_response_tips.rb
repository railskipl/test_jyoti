class CreateResponseTips < ActiveRecord::Migration
  def change
    create_table :response_tips do |t|
      t.integer :tip_id
      t.string :response_for_tip
      t.string :tag_tip
      t.integer :user_id

      t.timestamps
    end
  end
end
