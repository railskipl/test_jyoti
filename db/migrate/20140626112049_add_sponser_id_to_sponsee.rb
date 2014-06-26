class AddSponserIdToSponsee < ActiveRecord::Migration
  def change
    add_column :sponsees, :sponser_id, :integer
  end
end
