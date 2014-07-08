class AddRelationCheckedToRelationships < ActiveRecord::Migration
  def change
    add_column :relationships, :relation_checked, :boolean, :default => false
  end
end
