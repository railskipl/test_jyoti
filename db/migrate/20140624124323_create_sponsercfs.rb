class CreateSponsercfs < ActiveRecord::Migration
  def change
    create_table :sponsercfs do |t|
      t.integer :sponser_id
      t.integer :user_id
      t.string :name
      t.string :email

      t.timestamps
    end
  end
end
