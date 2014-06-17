class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :name
      t.integer :circle_id

      t.timestamps
    end
  end
end
