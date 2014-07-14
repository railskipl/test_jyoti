class AddRelationshipIdToTip < ActiveRecord::Migration
  def change
    add_column :tips, :relationship_id, :integer
  end
end
