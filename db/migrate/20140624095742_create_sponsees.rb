class CreateSponsees < ActiveRecord::Migration
  def change
    create_table :sponsees do |t|
      t.integer :user_id
      t.integer :relationship_id
      t.string :email
      t.boolean :approve_admin_custom_factor
      t.string :your_choise_custom_factor

      t.timestamps
    end
  end
end
