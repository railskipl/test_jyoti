class Rating < ActiveRecord::Base
	
attr_accessible :user_id,:friend_id,:trustworthy, :kind_helpful, :potential,:perform_well,:presentable,:emotianally_mature,:friendly_social,:count
belongs_to  :user
belongs_to  :friend, :class_name => 'User'

	def self.all_mirrors(ratingother, current_user)
        
		@trustworthy = (ratingother.average(:trustworthy)).to_f 
		@kind_helpful = (ratingother.average(:kind_helpful)).to_f
		@potential = (ratingother.average(:potential)).to_f
		@perform_well = (ratingother.average(:perform_well)).to_f
		@presentable = (ratingother.average(:presentable)).to_f
		@emotianally_mature = (ratingother.average(:emotianally_mature)).to_f
		@friendly_social = (ratingother.average(:friendly_social)).to_f
        
        
        a = [@trustworthy,@kind_helpful,@potential,@perform_well,@presentable,@emotianally_mature,@friendly_social]
        b = a.inject{ |sum, el| sum + el }.to_f / a.size #overall impression of all mirrors
        c = [b,@trustworthy,@kind_helpful,@potential,@perform_well,@presentable,@emotianally_mature,@friendly_social]
	end

	def self.self_mirrors(ratingss, current_user)
		self_rate = [ratingss[0].trustworthy, ratingss[0].kind_helpful, ratingss[0].potential, ratingss[0].perform_well, ratingss[0].presentable, ratingss[0].emotianally_mature, ratingss[0].friendly_social]
        d_rate = self_rate.inject{ |sum, el| sum + el }.to_f / self_rate.size
	    a = [d_rate,ratingss[0].trustworthy, ratingss[0].kind_helpful, ratingss[0].potential, ratingss[0].perform_well, ratingss[0].presentable, ratingss[0].emotianally_mature, ratingss[0].friendly_social]
	end

	def self.power_mirrors(c, current_user)
		@e = []
		c.each do |r|
		  
		  @group = Ratingother.where('user_id = ? and friend_id = ?', r[0], current_user ) rescue nil
		  unless @group.empty?
		   @e << @group
		  end
		end
        #raise @e.inspect
        if @e.size == 0
          @overall = [0, 0, 0, 0, 0, 0, 0, 0]
        elsif @e.size == 1
          @trustworthy = ((@e[0][0].trustworthy).to_f) 
		  @kind_helpful = ((@e[0][0].kind_helpful).to_f) 
		  @potential = (@e[0][0].potential).to_f
		  @perform_well = (@e[0][0].perform_well).to_f
		  @presentable = (@e[0][0].presentable ).to_f
		  @emotianally_mature = (@e[0][0].emotianally_mature ).to_f
		  @friendly_social = (@e[0][0].friendly_social ).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
    	elsif @e.size == 2
    	  @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy).to_f / 2).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful).to_f / 2).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential).to_f / 2).to_f 
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well).to_f / 2).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable).to_f / 2).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature).to_f / 2).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social).to_f / 2).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		 
		elsif @e.size == 3
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy).to_f / 3).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful).to_f / 3).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential).to_f / 3).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well).to_f / 3).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable).to_f / 3).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature).to_f / 3).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social).to_f / 3).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		elsif @e.size == 4
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy + @e[3][0].trustworthy).to_f / 4 ).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful + @e[3][0].kind_helpful).to_f / 4).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential + @e[3][0].potential).to_f / 4).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well + @e[3][0].perform_well).to_f / 4).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable + @e[3][0].presentable).to_f  / 4).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature + @e[3][0].emotianally_mature).to_f / 4).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social + @e[3][0].friendly_social).to_f / 4).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		elsif @e.size == 5
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy + @e[3][0].trustworthy + @e[4][0].trustworthy).to_f / 5).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful + @e[3][0].kind_helpful + @e[4][0].kind_helpful).to_f / 5).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential + @e[3][0].potential + @e[4][0].potential).to_f / 5).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well + @e[3][0].perform_well + @e[4][0].perform_well).to_f / 5).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable + @e[3][0].presentable + @e[4][0].presentable).to_f / 5).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature + @e[3][0].emotianally_mature + @e[4][0].emotianally_mature).to_f / 5).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social + @e[3][0].friendly_social + @e[4][0].friendly_social).to_f / 5).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		elsif @e.size == 6
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy + @e[3][0].trustworthy + @e[4][0].trustworthy + @e[5][0].trustworthy).to_f / 6).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful + @e[3][0].kind_helpful + @e[4][0].kind_helpful + @e[5][0].kind_helpful).to_f / 6).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential + @e[3][0].potential + @e[4][0].potential + @e[5][0].potential).to_f / 6).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well + @e[3][0].perform_well + @e[4][0].perform_well + @e[5][0].perform_well).to_f / 6).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable + @e[3][0].presentable + @e[4][0].presentable + @e[5][0].presentable).to_f / 6).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature + @e[3][0].emotianally_mature + @e[4][0].emotianally_mature + @e[5][0].emotianally_mature).to_f / 6).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social + @e[3][0].friendly_social + @e[4][0].friendly_social + @e[5][0].friendly_social).to_f / 6).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		elsif @e.size == 7
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy + @e[3][0].trustworthy + @e[4][0].trustworthy + @e[5][0].trustworthy + @e[6][0].trustworthy).to_f / 7).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful + @e[3][0].kind_helpful + @e[4][0].kind_helpful + @e[5][0].kind_helpful + @e[6][0].kind_helpful).to_f / 7).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential + @e[3][0].potential + @e[4][0].potential + @e[5][0].potential + @e[6][0].potential).to_f / 7).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well + @e[3][0].perform_well + @e[4][0].perform_well + @e[5][0].perform_well + @e[6][0].perform_well).to_f / 7).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable + @e[3][0].presentable + @e[4][0].presentable + @e[5][0].presentable + @e[6][0].presentable).to_f / 7).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature + @e[3][0].emotianally_mature + @e[4][0].emotianally_mature + @e[5][0].emotianally_mature + @e[6][0].emotianally_mature).to_f / 7).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social + @e[3][0].friendly_social + @e[4][0].friendly_social + @e[5][0].friendly_social + @e[6][0].friendly_social).to_f / 7).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w,@trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		elsif @e.size == 8
          @trustworthy = ((@e[0][0].trustworthy + @e[1][0].trustworthy + @e[2][0].trustworthy + @e[3][0].trustworthy + @e[4][0].trustworthy + @e[5][0].trustworthy + @e[6][0].trustworthy + @e[7][0].trustworthy).to_f / 8).to_f
		  @kind_helpful = ((@e[0][0].kind_helpful + @e[1][0].kind_helpful + @e[2][0].kind_helpful + @e[3][0].kind_helpful + @e[4][0].kind_helpful + @e[5][0].kind_helpful + @e[6][0].kind_helpful + @e[7][0].kind_helpful).to_f / 8).to_f
		  @potential = ((@e[0][0].potential + @e[1][0].potential + @e[2][0].potential + @e[3][0].potential + @e[4][0].potential + @e[5][0].potential + @e[6][0].potential + @e[7][0].potential).to_f / 8).to_f
		  @perform_well = ((@e[0][0].perform_well + @e[1][0].perform_well + @e[2][0].perform_well + @e[3][0].perform_well + @e[4][0].perform_well + @e[5][0].perform_well + @e[6][0].perform_well + @e[7][0].perform_well).to_f / 8).to_f
		  @presentable = ((@e[0][0].presentable + @e[1][0].presentable + @e[2][0].presentable + @e[3][0].presentable + @e[4][0].presentable + @e[5][0].presentable + @e[6][0].presentable + @e[7][0].presentable ).to_f / 8).to_f
		  @emotianally_mature = ((@e[0][0].emotianally_mature + @e[1][0].emotianally_mature + @e[2][0].emotianally_mature + @e[3][0].emotianally_mature + @e[4][0].emotianally_mature + @e[5][0].emotianally_mature + @e[6][0].emotianally_mature + @e[7][0].emotianally_mature).to_f / 8).to_f
		  @friendly_social = ((@e[0][0].friendly_social + @e[1][0].friendly_social + @e[2][0].friendly_social + @e[3][0].friendly_social + @e[4][0].friendly_social + @e[5][0].friendly_social + @e[6][0].friendly_social + @e[7][0].friendly_social).to_f / 8).to_f
		  @w = ((@trustworthy + @kind_helpful + @potential + @perform_well + @presentable + @emotianally_mature + @friendly_social).to_f / 7).to_f
		  @overall = [@w, @trustworthy, @kind_helpful, @potential, @perform_well, @presentable, @emotianally_mature, @friendly_social]
		else

        end
        
	end

	def all_mirrors_report
		raise "hi"
	end
end
