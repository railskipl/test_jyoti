class CreateReputationScores < ActiveRecord::Migration
  def change
    create_table :reputation_scores do |t|
      t.integer :user_id
      t.float :score

      t.timestamps
    end
  end
end
