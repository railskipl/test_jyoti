class CreatePowerGroups < ActiveRecord::Migration
  def change
    create_table :power_groups do |t|
      t.integer :user_id
      t.string :email
      t.string :your_influence
      t.string :influence_on_your

      t.timestamps
    end
  end
end
