class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.string :email
      t.integer :know_how_for_long_year
      t.integer :know_how_for_long_month
      t.string :how_well_you_know_the_person
      t.string :your_influence
      t.string :influence_on_your
      t.integer :user_id

      t.timestamps
    end
  end
end
