class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.string :name
      t.string :email
      t.text :description

      t.timestamps
    end
  end
end
