class AddNameToSponsee < ActiveRecord::Migration
  def change
    add_column :sponsees, :name, :string
  end
end
