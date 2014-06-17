class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
