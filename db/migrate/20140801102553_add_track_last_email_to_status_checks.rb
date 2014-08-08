class AddTrackLastEmailToStatusChecks < ActiveRecord::Migration
  def change
    add_column :status_checks, :track_last_email, :text
  end
end
