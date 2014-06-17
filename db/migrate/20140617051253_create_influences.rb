class CreateInfluences < ActiveRecord::Migration
  def change
    create_table :influences do |t|
      t.string :your_influence
      t.string :influence_on_your

      t.timestamps
    end
  end
end
