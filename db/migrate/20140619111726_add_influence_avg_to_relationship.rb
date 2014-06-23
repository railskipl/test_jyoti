class AddInfluenceAvgToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :influence_avg, :float
  end
end
