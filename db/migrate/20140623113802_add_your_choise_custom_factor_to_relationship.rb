class AddYourChoiseCustomFactorToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :your_choise_custom_factor, :string
  end
end
