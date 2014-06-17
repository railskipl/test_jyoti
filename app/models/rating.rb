class Rating < ActiveRecord::Base
attr_accessible :user_id,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:count
belongs_to  :user
end
