class AddHowLongYouKnowEachOtherAvgToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :how_long_you_know_each_other_avg, :float
  end
end
