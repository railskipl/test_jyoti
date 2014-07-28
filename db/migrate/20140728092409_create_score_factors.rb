class CreateScoreFactors < ActiveRecord::Migration
  def change
    create_table :score_factors do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
