class CreateAvgRatings < ActiveRecord::Migration
  def change
    create_table :avg_ratings do |t|
      t.float :trustworthy
      t.float :kind_helpful
      t.float :potential
      t.float :presentable 
      t.float :perform_well
      t.float :emotianally_mature
      t.float :friendly_social
      t.float :overall
      t.integer :user_id

      t.timestamps
    end
  end
end
