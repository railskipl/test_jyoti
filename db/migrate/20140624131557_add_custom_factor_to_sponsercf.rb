class AddCustomFactorToSponsercf < ActiveRecord::Migration
  def change
    add_column :sponsercfs, :custom_factor, :string
  end
end
