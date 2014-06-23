class Rating < ActiveRecord::Base
attr_accessible :user_id,:friend_id,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:count
belongs_to  :user
belongs_to  :friend, :class_name => 'User'
end
