class AddCircleIdToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :circle_id, :integer
  end
end
