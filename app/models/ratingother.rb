class Ratingother < ActiveRecord::Base
 attr_accessible :user_id,:email,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:rate_count
 belongs_to  :user
 belongs_to :advice_contact
 validates_presence_of :email



def category_name
  user.email if user
end

def category_name=(name)
  self.user = User.find_or_create_by_email(email) unless email.blank?
end


end
