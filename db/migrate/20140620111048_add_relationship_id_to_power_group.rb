class AddRelationshipIdToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :relationship_id, :integer
  end
end
