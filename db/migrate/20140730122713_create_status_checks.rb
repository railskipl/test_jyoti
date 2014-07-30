class CreateStatusChecks < ActiveRecord::Migration
  def change
    create_table :status_checks do |t|
      t.boolean :give_feedback, :default => false
      t.boolean :give_rating, :default => false
      t.boolean :self_image, :default => false
      t.boolean :vote_on_tips, :default => false
      t.boolean :invite_others, :default => false

      t.timestamps
    end
  end
end
