class CreateAccessReputationTips < ActiveRecord::Migration
  def change
    create_table :access_reputation_tips do |t|
      t.integer :user_id
      t.integer :give_feedback, :default => 0
      t.integer :vote_on_tips, :default => 0
      t.integer :invite_other, :default => 0
      t.integer :give_ratings, :default => 0
      t.integer :give_selfimage, :default => 0
      t.integer :got_feedback, :default => 0

      t.timestamps
    end
  end
end
