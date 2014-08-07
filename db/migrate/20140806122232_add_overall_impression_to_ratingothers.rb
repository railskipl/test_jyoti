class AddOverallImpressionToRatingothers < ActiveRecord::Migration
  def change
    add_column :ratingothers, :overall_impresions, :integer
  end
end
