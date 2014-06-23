class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.text :praise_tips
      t.text :criticism_tips
      t.text :helpful_tips

      t.timestamps
    end
  end
end
