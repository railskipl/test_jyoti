class AddApproveCustomFactorToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :approve_custom_factor, :boolean
  end
end
