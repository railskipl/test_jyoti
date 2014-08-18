class CreateVoteTracks < ActiveRecord::Migration
  def change
    create_table :vote_tracks do |t|
      t.integer :user_id
      t.string :name

      t.timestamps
    end
  end
end
