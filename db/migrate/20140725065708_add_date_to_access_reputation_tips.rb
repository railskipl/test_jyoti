class AddDateToAccessReputationTips < ActiveRecord::Migration
  def change
    add_column :access_reputation_tips, :start_date, :string
    add_column :access_reputation_tips, :end_date, :string
    add_column :access_reputation_tips, :intial_reaction_view, :boolean, :default => false
    add_column :access_reputation_tips, :intial_reputation_view, :boolean, :default => false
  end
end
