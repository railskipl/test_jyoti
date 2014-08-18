module RatingsHelper
	def avg_result(column_attribute,value)
	  scores = AvgRating.pluck(column_attribute.to_sym)
	  count = 0
   	  scores.each do |i| 
       if i < value
        count += 1 
       elsif (i == value && scores.count == 1)
        count += 1  	
       end 
  	  end 
	 val =  ((count.to_f/scores.count)*100).round(2)
	 return "#{val}%" 
	end


	def rhd_store_function(column_attribute,value)
		scores = RhdStore.pluck(column_attribute.to_sym)
		count = 0
   	    scores.each do |i| 
          if i < value 
            count += 1 
          elsif (i == value && scores.count == 1)
            count += 1 
          end 
  	    end 
	    val =  ((count.to_f/scores.count)*100).round(2)
	    return "#{val}%" 
	end


	def score_factor_name(column_attribute,value)
		ScoreFactor.find_by_name_and_factor_type(column_attribute.to_s,value).name.camelize rescue nil
	end


	def score_factor_description(column_attribute,value)
		ScoreFactor.find_by_name_and_factor_type(column_attribute.to_s,value).description rescue nil 
	end

	# def avg_result_percent(avg,avg_result1)
	#  avg_result1.overall = avg_result("overall",avg.overall)
	#  avg_result1.trustworthy = avg_result("trustworthy",avg.trustworthy)
	#  avg_result1.kind_helpful = avg_result("kind_helpful",avg.kind_helpful)
	#  avg_result1.potential = avg_result("potential",avg.potential)
	#  avg_result1.presentable = avg_result("presentable",avg.presentable)
	#  avg_result1.perform_well = avg_result("perform_well",avg.perform_well)
	#  avg_result1.emotianally_mature = avg_result("emotianally_mature",avg.emotianally_mature)
	#  avg_result1.friendly_social = avg_result("friendly_social",avg.friendly_social)
	#  avg_result1.user_id = current_user.id
	#  avg_result1.save
	# end


	def condition_check 
	   @powergroup = PowerGroup.where('user_id = ?', current_user.id) rescue nil
	   @c = []
	   @powergroup.each do |r|
	     @c << User.where('email = ?', r.email).select('id')
	   end
	   
	   @d = Rating.power_mirrors(@c, current_user.id)#power mirrors
	   if @d.empty?
	    @d = [0,0,0,0,0,0,0,0]
	   else
	    @d = Rating.power_mirrors(@c, current_user.id)#power mirrors
	   end

	   @ratingss = Rating.where('user_id = ?', current_user.id) rescue nil#self image
	   @ratingother = Ratingother.where('friend_id = ?', current_user.id) rescue nil#all mirrors
	   if @ratingother.empty? && @ratingss.empty?
	    @b = [0,0,0,0,0,0,0,0]#self image
	    @a = [0,0,0,0,0,0,0,0]#all mirrors
	   elsif @ratingother.empty? && @ratingss != nil
	    @b = Rating.self_mirrors(@ratingss, current_user.id)#self image
	    @a = [0,0,0,0,0,0,0,0]#all mirrors
	   elsif @ratingss.empty? && @ratingother != nil
	    @b = [0,0,0,0,0,0,0,0]#self image
	    @a = Rating.all_mirrors(@ratingother,current_user.id) #all mirrors  
	   else
	    @b = Rating.self_mirrors(@ratingss, current_user.id)#self image
	    @a = Rating.all_mirrors(@ratingother,current_user.id) #all mirrors  
	   end


	   @avg = AvgRating.where("user_id = ?",current_user.id).first_or_create
	   
	   unless @a.empty?
	     @avg.overall = @a[0]
	     @avg.trustworthy = @a[1]
	     @avg.kind_helpful = @a[2]
	     @avg.potential = @a[3]
	     @avg.presentable = @a[4]
	     @avg.perform_well = @a[5]
	     @avg.emotianally_mature = @a[6]
	     @avg.friendly_social = @a[7]
	     @avg.user_id = current_user.id
	     @avg.save
	   end
	   report
    end

	def report
	  @user = current_user
	  @total_ratings = Ratingother.where("email like ?" ,@user.email).count
	  @recent_ratings = Ratingother.where("email like ? and created_at >= ?" ,@user.email, 6.months.ago).count
	  @total_relations = Relationship.where("email like ?" ,@user.email).count
	  if @total_ratings > 0 
	    @percent = @recent_ratings*100/@total_ratings
	  
	    @long_relations = Relationship.where("email like ? and know_how_for_long_year >= ?" ,@user.email,2).count
	    if @total_relations > 0
	    @percent_history = @long_relations*150/@total_relations
	    end
	    @tr = Ratingother.where("email like ?" ,@user.email)
	    if @total_ratings > 100
	      @diversity_points = 150
	    else
	      @diversity_points = (@total_ratings*150)/100
	    end
	    
	    @weighted_rating ||= []
	    @tr.each do |r| 
	     reputation_score = ReputationScore.find_by_user_id(r.user_id).nil? ? 1:reputation_score = ReputationScore.find_by_user_id(r.user_id).score
	     @weighted_rating << ((r.trustworthy*0.2 + r.kind_helpful*0.1 + r.potential*0.1 + r.perform_well*0.2 + r.presentable*0.1+ r.emotianally_mature*0.15 + r.friendly_social*0.15)*(reputation_score*0.1)).to_i
	    end 
	    @total_score = @percent + @percent_history.to_f + @diversity_points + @weighted_rating.sum/@total_ratings 
	    r = ReputationScore.where("user_id = ?", current_user).first_or_create
	    r.user_id = current_user.id
	    r.score = @total_score
	    r.save
	    rhd = RhdStore.where(:user_id => current_user.id).first_or_create
	    rhd.recency = @percent
	    rhd.history = @percent_history.to_f 
	    rhd.diversity = @diversity_points
	    rhd.save
	    end
	end

	def date_check
		@start_date = (Date.today - 30.days).to_s
        @end_date = Date.today.to_s
	end

	def tips_provided
		date_check
		@praise = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
        @criticism = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
        @general = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id = ?',@start_date,@end_date,current_user.id).order('created_at DESC') rescue nil
	end

	def votes_invites_track
		date_check
		@vote_track = VoteTrack.where('created_at >= ? and Date(created_at) <= ? and user_id = ? and name = ?',@start_date,@end_date,current_user.id, "vote_on_tips").order('created_at DESC') rescue nil
        @track_invites = VoteTrack.where('created_at >= ? and Date(created_at) <= ? and user_id = ? and name = ?',@start_date,@end_date,current_user.id, "invitations").order('created_at DESC') rescue nil
	end

	def tips_other
		date_check
		@criticisms = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
        @critic = Criticism.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
        @all_critic = @criticisms.count + @critic.count

        @praises = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
        @praisecount = Praise.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
        @all_praise = @praises.count + @praisecount.count
        #raise @all_praise.inspect

        @generals = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id != ? and email = ? and status = ?',@start_date,@end_date,current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
        @generalcount = General.where('created_at >= ? and Date(created_at) <= ? and provider_user_id IS ? and email = ? and status = ?', @start_date, @end_date, nil, current_user.email, false).order('created_at DESC') rescue nil    
        @all_general = @generals.count + @generalcount.count
	end

	def gottips
    @criticisms = Criticism.where('provider_user_id != ? and email = ? and status = ?',current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @critic = Criticism.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_critic = @criticisms.count + @critic.count
    
    @praises = Praise.where('provider_user_id != ? and email = ? and status = ?',current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @praisecount = Praise.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_praise = @praises.count + @praisecount.count
    #raise @all_praise.inspect
    
    @generals = General.where('provider_user_id != ? and email = ? and status = ?', current_user.id, current_user.email, false).select('DISTINCT(provider_user_id)').order('created_at DESC') rescue nil
    @generalcount = General.where('provider_user_id IS ? and email = ? and status = ?', nil, current_user.email, false).order('created_at DESC') rescue nil    
    all_general = @generals.count + @generalcount.count

    if all_critic >= 5 
       a = all_critic
    elsif all_praise >= 5
       a = all_praise
    elsif all_general >= 5
       a = all_general
    else
      if all_critic <= 5
        a = all_critic
      elsif all_praise <= 5
        a = all_praise
        else
          a = all_general
        end
    end
 end
end
