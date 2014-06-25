class CreateSponsers < ActiveRecord::Migration
  def change
    create_table :sponsers do |t|
      t.string :name
      t.string :custom_factor

      t.timestamps
    end
  end
end
