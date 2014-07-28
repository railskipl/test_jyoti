class AddFactorTypeToScoreFactors < ActiveRecord::Migration
  def change
    add_column :score_factors, :factor_type, :string
  end
end
