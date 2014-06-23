class CreateRatingothers < ActiveRecord::Migration
  def change
    create_table :ratingothers do |t|
      t.string  :email
      t.string  :user_id
      t.integer :friend_id
      t.integer :trustworthy
      t.integer :kind_helpful
      t.integer :potential
      t.integer :perform_well
      t.integer :presentable
      t.integer :emotianally_mature
      t.integer :friendly_social
      t.integer :rate_count


      t.timestamps
    end
  end
end
