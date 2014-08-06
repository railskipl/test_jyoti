class AddOverallImpressionToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :overall_impresions, :integer
  end
end
