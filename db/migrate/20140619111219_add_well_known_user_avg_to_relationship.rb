class AddWellKnownUserAvgToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :well_known_user_avg, :float
  end
end
