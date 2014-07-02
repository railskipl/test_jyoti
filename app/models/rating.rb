class Rating < ActiveRecord::Base
	
attr_accessible :user_id,:friend_id,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:count
belongs_to  :user
belongs_to  :friend, :class_name => 'User'

	def self.all_mirrors(ratingother, current_user, ratingss)
     
		@trustworthy = (ratingother.average(:trustworthy)).to_f 
		@kind_helpful = (ratingother.average(:kind_helpful)).to_f
		@potential = (ratingother.average(:potential)).to_f
		@perform_well = (ratingother.average(:perform_well)).to_f
		@presentable = (ratingother.average(:presentable)).to_f
		@emotianally_mature = (ratingother.average(:emotianally_mature)).to_f
		@friendly_social = (ratingother.average(:friendly_social)).to_f
        
        self_rate = [ratingss[0].trustworthy, ratingss[0].kind_helpful, ratingss[0].potential, ratingss[0].perform_well, ratingss[0].presentable, ratingss[0].emotianally_mature, ratingss[0].friendly_social]
        d_rate = self_rate.inject{ |sum, el| sum + el }.to_f / self_rate.size
        a = [@trustworthy,@kind_helpful,@potential,@perform_well,@presentable,@emotianally_mature,@friendly_social]
        b = a.inject{ |sum, el| sum + el }.to_f / a.size
        c = [b,@trustworthy,@kind_helpful,@potential,@perform_well,@presentable,@emotianally_mature,@friendly_social, d_rate]
	end
end
