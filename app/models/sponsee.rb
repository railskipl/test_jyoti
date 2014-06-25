class Sponsee < ActiveRecord::Base
	attr_accessible :user_id, :relationship_id, :email, :approve_admin_custom_factor, :your_choise_custom_factor,:custom_factor,:name
    belongs_to :user
    belongs_to :relationship
    belongs_to :sponsercf    
end
