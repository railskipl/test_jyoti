class TipsController < ApplicationController
 before_filter :authenticate_user!
	# before_filter :authenticate_user!
	# before_filter :check_user, only: [:new,:index]

	def index
		@users = User.all
	 @response_tip = ResponseTip.all
		@tips = Tip.all
		@user_invitations = UserInvitation.all
		
	end

	def advice
	  @tips = Tip.all  
	end

	def new
	 @tip = Tip.new
	end


    def create
	@tip = Tip.new(params[:tip])
	    if @tip.praise.present? && @tip.criticism.present? || @tip.praise.present? && @tip.helpful.present? || @tip.criticism.present? && @tip.helpful.present?
         @praise = Praise.new(:email => @tip.email, :provider_user_id => @tip.user_id, :praise_comment => @tip.praise, :typee => "praise", :circle_name => @tip[:name])
		 @praise.save! 
		
		 @criticism = Criticism.new(:email => @tip.email, :provider_user_id => @tip.user_id, :criticism_comment => @tip.criticism, :typee => "criticism", :circle_name => @tip[:name])
		 @criticism.save!

		 @general = General.new(:email => @tip.email, :provider_user_id => @tip.user_id, :general_comment => @tip.helpful, :typee => "general", :circle_name => @tip[:name])
		 @general.save!


		if params[:tip][:rating] == "true"
			redirect_to new_ratingother_path(:email => @tip.email), notice: "Tips has been provided to this particular user."
		else
			redirect_to my_mirror_paste_users_path, notice: "Tips has been provided to this particular user."
		end
		else
		  redirect_to new_tip_path
          flash[:notice] = 'Please Give atleast Two tips'
		end
	end

    def destroy
		@tip = Tip.find(params[:id])
		@tip.destroy
		redirect_to power_tips_tips_path
	end


	def merge_email
		@merge_email = User.find(params[:id])
	end

	def demerge_email
	end
 
	def check_history
		 @tips = Tip.where('user_id = ?', current_user.id)
		
	end

	def helpful_tips

		@praise = Praise.where('provider_user_id != ?', current_user.id)
		@praises = Praise.where('email != ?', current_user.email)

		@criticism = Criticism.where('provider_user_id != ?', current_user.id)
		@criticisms = Criticism.where('email != ?', current_user.email)

		@general = General.where('provider_user_id != ?', current_user.id)
		@generals = General.where('email != ?', current_user.email)
		
		
		@second_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
		@zero_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
		
		@second_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ? ', 1, 1, 1 ).order("RANDOM()").first rescue nil
		@zero_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
		
		@second_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed >= ?', 1, 1, 1 ).order("RANDOM()").first rescue nil
		@zero_priority3 = @generals.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
		
		h = [@second_priority1,@second_priority2,@second_priority3]
		@second_priority = h.shuffle.sample
		
		v = [@zero_priority1,@zero_priority2,@zero_priority3]
		@zero_priority = v.shuffle.sample

		if @second_priority.present?
			@priority = @second_priority
		else
			@priority = @zero_priority
		end
		@power = PowerGroup.where('email = ? and circle_name = ?', current_user.email, @priority.circle_name) rescue nil
		if @power.blank?
		 @ww = @priority
		end
		
	end

	def admin_approve_tip
		 @tips = Tip.where('user_id != ?', current_user.id )
		 @tipss = @tips.where('email != ?', current_user.email)
		 
		 @second_priority = @tipss.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 2, 0, 0).order("RANDOM()").first rescue nil
		 if @second_priority.present?
			@priority = @second_priority
			@ww = @priority
			@created_at = @ww.created_at.to_date
			# @b =  @created_at.to_date
			@a = DateTime.now.to_date - 1.day
		 end
	end


	def tips_response

	   if params[:typee] == "praise"
         @tip = Praise.find(params[:id])
         Suggestion.create(:feedback_comment => params[:suggestions], :praise_id => @tip.id, 
         	               :provider_user_id => current_user.id, :recipient_email => @tip.email, 
         	               :comment_quality => params[:quality_of_comments] )
	   elsif params[:typee] == "criticism"
         @tip = Criticism.find(params[:id])
         Suggestion.create(:feedback_comment => params[:suggestions], :criticism_id => @tip.id, 
         	               :provider_user_id => current_user.id, :recipient_email => @tip.email, 
         	               :comment_quality => params[:quality_of_comments] )
	   else  params[:typee] == "general"
	   	 @tip = General.find(params[:id])
	   	 Suggestion.create(:feedback_comment => params[:suggestions], :general_id => @tip.id, 
         	               :provider_user_id => current_user.id, :recipient_email => @tip.email, 
         	               :comment_quality => params[:quality_of_comments] )
	   end
	   	
		sum = 1
		user_view = 1
		#logic for decidind the tip is helpful or not
		if @tip.tip_accept = 2
			@w = 1           #for deciding helpful tip
		elsif @tip.tip_reject = 2 
			@w = 2          #for deciding unhelpful tip
		else 
			@w = 0
		end
	 
		if params[:response] == "true"
			@sum = @tip.tip_accept + sum
			@tip.tip_accept = @sum
		else
			@sum = @tip.tip_reject + sum
			@tip.tip_reject = @sum
		end
		@tip.tip_prediction = @w
		@tip.tip_viewed = @tip.tip_viewed + user_view
		if params[:typee] == "praise"
         @tip.update_attributes(params[:praise])
	    elsif params[:typee] == "criticism"
         @tip.update_attributes(params[:criticism])
	    else  params[:typee] == "general"
	   	 @tip.update_attributes(params[:general])
	    end
	    #for onbording sequence quality check
	    @quality_check = AccessReputationTip.where(:user_id => current_user.id)
	    if @quality_check
	    	a = 1
	    	@quality_check.first.vote_on_tips = @quality_check.first.vote_on_tips + a
	    	@aa = @quality_check.first.update_attributes(params[:access_reputation_tip])
	    end
		flash[:notice] = "Thanks for particiption."
		redirect_to helpful_tips_tips_path
	end

	def power_tips
		@tips = Tip.all
	end

	def react_to_response
	   if params[:praise_id].present?
	   	 @praise = Praise.where(:id => params[:praise_id])
	   elsif params[:criticism_id].present?
	   	 @criticism = Criticism.where(:id => params[:criticism_id])
	   	 raise @criticism.inspect
	   else params[:general_id].present?
	   	 @general = General.where(:id => params[:general_id])
	   end
	end

	def submit_response
	   if params[:praise_id]
	   	  @praise = Praise.where(:id => params[:praise_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:praise_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @praise.first.provider_user_id)
	   elsif params[:criticism_id]
	   	  @criticism = Criticism.where(:id => params[:criticism_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:criticism_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @criticism.first.provider_user_id)
	   else params[:general_id]
	   	  @criticism = Criticism.where(:id => params[:general_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:general_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @general.first.provider_user_id)
	   end

       flash[:notice] = "Response successfully posted."
	   redirect_to responses_to_your_tips_tips_path
	end

	def reaction_for_response
	  @response = Response.where(:id => params[:response_id])

	  if @response.first.praise_id.present?
	  	 @praise = Praise.where(:id => @response.first.praise_id)
	  elsif @response.first.criticism_id.present?
	  	 @criticism = Criticism.where(:id => @response.first.criticism_id)
	  else
	  	 @general = General.where(:id => @response.first.general)
	  end
	end

	def submit_reaction
		@response = Response.where(:id => params[:response_id])
		if params[:praise_id]
	   	  @praise = Praise.where(:id => params[:praise_id])
	   	  @reaction = Reaction.create(:reaction_comment => params[:reaction_comment], 
	   	  	          :praise_id => params[:praise_id]  , :reciver_user_id =>@response.first.response_user_id , 
	   	  	          :provider_user_id => current_user.id, :response_id => @response.first.id)
	   elsif params[:criticism_id]
	   	  @criticism = Criticism.where(:id => params[:criticism_id])
	   	  @reaction = Reaction.create(:reaction_comment => params[:reaction_comment], 
	   	  	          :criticism_id => params[:criticism_id]  , :reciver_user_id =>@response.first.response_user_id , 
	   	  	          :provider_user_id => current_user.id, :response_id => @response.first.id)
	   else params[:general_id]
	   	  @criticism = Criticism.where(:id => params[:general_id])
	   	  @reaction = Reaction.create(:reaction_comment => params[:reaction_comment], 
	   	  	          :general_id => params[:general_id]  , :reciver_user_id =>@response.first.response_user_id , 
	   	  	          :provider_user_id => current_user.id, :response_id => @response.first.id)
	   end

       flash[:notice] = "Reaction successfully posted."
	   redirect_to responses_to_your_tips_tips_path	
	end
	
 def unhelpful_tips
	 
 end

 def tips
	 
 end

 def tip
	 
 end

 def respond_tips
	
 end

 
 def responses_to_your_tips
	@praise = Praise.where(:email => current_user.email) rescue nil
	@criticism = Criticism.where(:email => current_user.email) rescue nil
	@general = General.where(:email => current_user.email) rescue nil

	@praise_owner_tip = Praise.where(:provider_user_id => current_user.id) rescue nil
	@criticism_owner_tip = Criticism.where(:provider_user_id => current_user.id) rescue nil
	@general_owner_tip = General.where(:provider_user_id => current_user.id) rescue nil
 end

 def tips_and_rating
	 
 end

 def rejected_tips
	 
 end

private
		# Use callbacks to share common setup or constraints between actions.

		# def check_user
		#   if user_signed_in?
		#   else
		#     redirect_to root_path, :alert => "Unauthorised Access"
		#   end
		 
		# end


end
