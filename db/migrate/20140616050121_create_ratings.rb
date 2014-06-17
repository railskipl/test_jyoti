class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
    	t.integer  :user_id
    	t.integer :trustworthy
    	t.integer :kind_helpful
    	t.integer :potential
    	t.integer :perform_well
    	t.integer :presentable
    	t.integer :emotianally_mature
    	t.integer :friendly_social

      t.timestamps
    end
  end
end
