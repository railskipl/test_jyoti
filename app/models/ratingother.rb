class Ratingother < ActiveRecord::Base
 attr_accessible :user_id,:email,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:rate_count
 belongs_to  :user

end
