class CreateRhdStores < ActiveRecord::Migration
  def change
    create_table :rhd_stores do |t|
      t.float :recency
      t.float :history
      t.float :diversity
      t.integer :user_id

      t.timestamps
    end
  end
end
