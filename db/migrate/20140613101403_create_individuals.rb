class CreateIndividuals < ActiveRecord::Migration
  def change
    create_table :individuals do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
