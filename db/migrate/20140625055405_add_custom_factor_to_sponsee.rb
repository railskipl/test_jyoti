class AddCustomFactorToSponsee < ActiveRecord::Migration
  def change
    add_column :sponsees, :custom_factor, :string
  end
end
