class AddRelationshipIdToInfluence < ActiveRecord::Migration
  def change
    add_column :influences, :relationship_id, :integer
  end
end
