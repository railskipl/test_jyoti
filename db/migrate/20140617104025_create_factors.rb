class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :custom_factor
      t.integer :circle_id

      t.timestamps
    end
  end
end
