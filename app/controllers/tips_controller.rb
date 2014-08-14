class TipsController < ApplicationController
 include TipsHelper
 before_filter :authenticate_user!
	# before_filter :authenticate_user!
	# before_filter :check_user, only: [:new,:index]

	# def index
	# 	@users = User.all
	#     @response_tip = ResponseTip.all
	# 	@tips = Tip.all
	# 	@user_invitations = UserInvitation.all
		
	# end

	def advice
	  #@tips = Tip.all  
	end

	def new
	 @tip = Tip.new
	end


    def create
	    @tip = Tip.new(params[:tip])
        #for onbording sequence got feedback to others  
        @user = User.where('email = ?', @tip.email) rescue nil
        if @user.present?
	        @gotfeedback = AccessReputationTip.where('user_id = ?', @user.first.id) rescue nil
		    if @gotfeedback
		    	a = 1
		    	@gotfeedback.first.got_feedback = @gotfeedback.first.got_feedback + 1
		    	@gotfeedback.first.update_attributes(params[:access_reputation_tip])
		    end
		end
	    if @tip.praise.present? && @tip.criticism.present? || @tip.praise.present? && @tip.helpful.present? || @tip.criticism.present? && @tip.helpful.present?
	     
	        if user_signed_in?
	        	#for onbording sequence give feedback to others
	            @givefeedback = AccessReputationTip.where('user_id = ?', current_user.id) 
	            if @givefeedback
	            	a = 1 
	            	@givefeedback.first.give_feedback = @givefeedback.first.give_feedback + a
	            	@givefeedback.first.update_attributes(params[:access_reputation_tip])
	            end
	        end
	        if @tip.praise
	         	@praise = Praise.new(:email => @tip.email, :provider_user_id => @tip.user_id, :praise_comment => @tip.praise, :typee => "praise", :circle_name => @tip[:name], :city => current_user.city)
			 	@praise.save
			end
		
			if @tip.criticism
			  @criticism = Criticism.new(:email => @tip.email, :provider_user_id => @tip.user_id, :criticism_comment => @tip.criticism, :typee => "criticism", :circle_name => @tip[:name], :city => current_user.city)
			  @criticism.save
	        end

	        if @tip.helpful
			  @general = General.new(:email => @tip.email, :provider_user_id => @tip.user_id, :general_comment => @tip.helpful, :typee => "general", :circle_name => @tip[:name], :city => current_user.city)
			  @general.save
	        end

			if params[:tip][:rating] == "true"
				redirect_to new_ratingother_path(:email => @tip.email), notice: "Tips has been provided to this particular user."
			else
				redirect_to my_mirror_paste_users_path, notice: "Tips has been provided to this particular user."
			end
		else
			redirect_to new_tip_path
	        flash[:notice] = 'Please give at least two out of three tips to complete this step. The quality of your tips matter too.'
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
		
	end

	def votes
		@praise = Praise.where('provider_user_id != ? ', current_user.id)
		@praises = Praise.where('email != ? and city != ? or city IS ?', current_user.email, current_user.city,nil)

		@criticism = Criticism.where('provider_user_id != ?', current_user.id)
		@criticisms = Criticism.where('email != ? and city != ? or city IS ?', current_user.email, current_user.city,nil)

		@general = General.where('provider_user_id != ?', current_user.id)
		@generals = General.where('email != ? and city != ? or city IS ?', current_user.email, current_user.city, nil)
		
		
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
	   	@vote_track = VoteTrack.create(:user_id => current_user.id, :name => 'vote_on_tips')
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
	    @quality_check = AccessReputationTip.where('user_id = ?', current_user.id)
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
	   	 @praise = Praise.where('id = ?', params[:praise_id])
	   elsif params[:criticism_id].present?
	   	 @criticism = Criticism.where('id = ?', params[:criticism_id])
	   	 raise @criticism.inspect
	   else params[:general_id].present?
	   	 @general = General.where('id = ?', params[:general_id])
	   end
	end

	def submit_response
	   if params[:praise_id]
	   	  @praise = Praise.where('id = ?', params[:praise_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:praise_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @praise.first.provider_user_id)
	   elsif params[:criticism_id]
	   	  @criticism = Criticism.where('id = ?', params[:criticism_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:criticism_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @criticism.first.provider_user_id)
	   else params[:general_id]
	   	  @general = General.where('id = ?', params[:general_id])
	   	  @response = Response.create(:response_comment => params[:response_comment], 
	   	  	          :praise_id => params[:general_id]  , :response_user_id => current_user.id, 
	   	  	          :provider_user_id => @general.first.provider_user_id)
	   end

       flash[:notice] = "Response successfully posted."
	   redirect_to responses_to_your_tips_tips_path
	end

	def reaction_for_response
	  @response = Response.where('id = ?',params[:response_id])

	  if @response.first.praise_id.present?
	  	 @praise = Praise.where('id = ?', @response.first.praise_id)
	  elsif @response.first.criticism_id.present?
	  	 @criticism = Criticism.where('id = ?', @response.first.criticism_id)
	  else
	  	 @general = General.where('id = ?', @response.first.general)
	  end
	end

	def submit_reaction
		@response = Response.where('id = ?', params[:response_id])
		if params[:praise_id]
	   	  @praise = Praise.where('id = ?', params[:praise_id])
	   	  @reaction = Reaction.create(:reaction_comment => params[:reaction_comment], 
	   	  	          :praise_id => params[:praise_id]  , :reciver_user_id =>@response.first.response_user_id , 
	   	  	          :provider_user_id => current_user.id, :response_id => @response.first.id)
	   elsif params[:criticism_id]
	   	  @criticism = Criticism.where('id = ?', params[:criticism_id])
	   	  @reaction = Reaction.create(:reaction_comment => params[:reaction_comment], 
	   	  	          :criticism_id => params[:criticism_id]  , :reciver_user_id =>@response.first.response_user_id , 
	   	  	          :provider_user_id => current_user.id, :response_id => @response.first.id)
	   else params[:general_id]
	   	  @criticism = Criticism.where('id = ?', params[:general_id])
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
 	@reputation_and_tip = AccessReputationTip.where('user_id = ?',current_user.id)
  unless @reputation_and_tip.first.intial_reaction_view == true && @reputation_and_tip.first.intial_reputation_view == true
    # Initial case 
    if @reputation_and_tip.first.give_feedback >= 1 && @reputation_and_tip.first.give_ratings >= 1 && @reputation_and_tip.first.vote_on_tips >= 5 && @reputation_and_tip.first.give_selfimage >= 1 && gottips >= 5 && @reputation_and_tip.first.invite_other >= 5 
      #for intial report // setting of logic for onbording sequence
          @reputation_and_tip.first.intial_reaction_view = true
          @reputation_and_tip.first.start_date = Date.today.to_s 
          @reputation_and_tip.first.end_date = (Date.today + 7.days).to_s
          @reputation_and_tip.first.update_attributes(params[:access_reputation_tip])
        ############################################################################### 
          condition_check      
    else
      redirect_to reputation_report_failure_path
    end
  else
    #After initial view of reputation report and tips.
    #This condition will give user to access reputation report and tips for next 7 days.
    @a = Date.today.to_date - (@reputation_and_tip.first.start_date).to_date
    if @a.to_i <= 7
      condition_check
    else
      # This condition used to check last 30 days data for fullfilling the critria to view 
      # reputation reports and tips.
        date_check
        votes_invites_track
        tips_provided
        #####################################################################
        # Tips from 3 diffrent people.
        tips_other 
        ###################################################

      @tip = @praise.count + @criticism.count + @general.count
      if @tip >= 10 && @vote_track.count >= 25 && @track_invites.count >= 3
        #This condition is for to check:
        # 1.User should provide more than 10 tips to other users.
        # 2.Provide 25 vote on tips or more.
        # 3.Send Invites to 3 or more people. 
        if @all_critic >= 3 || @all_praise >= 3 || @all_general >= 3
             # This condition will check for, does user got tips from 3 or more people for last 
             # 30 days.
          condition_check
        else
           redirect_to reputation_report_failure2_path(:case => '2', :id => current_user.id)
        end
      else
        redirect_to reputation_report_failure1_path
      end 
    end  
  end
 end

 def tips_and_rating
	 
 end

 def rejected_tips
	 
 end

end
 
