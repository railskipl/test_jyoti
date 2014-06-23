class AddNameToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :name, :string
  end
end
