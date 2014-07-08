class AddAnonymousUserToRatingothers < ActiveRecord::Migration
  def change
    add_column :ratingothers, :anonymous_user, :boolean, :default => false
  end
end
