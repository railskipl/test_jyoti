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

	@praise = Praise.create(:email => @tip.email, :provider_user_id => @tip.user_id, :praise_comment => @tip.praise, :typee => "praise")
	@criticism = Criticism.create(:email => @tip.email, :provider_user_id => @tip.user_id, :criticism_comment => @tip.criticism, :typee => "criticism")
	@general = General.create(:email => @tip.email, :provider_user_id => @tip.user_id, :general_comment => @tip.helpful, :typee => "general")
	if params[:tip][:rating] == "true"
		redirect_to new_ratingother_path(:email => @tip.email), notice: "Tips has been provided to this particular user."
	else
		redirect_to my_mirror_paste_users_path, notice: "Tips has been provided to this particular user."
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
		
		
		@second_priority1 = @praises.where('tip_accept = ? or tip_reject = ?', 1, 1 ).order("RANDOM()").first rescue nil
		@zero_priority1 = @praises.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
		
		@second_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? ', 1, 1 ).order("RANDOM()").first rescue nil
		@zero_priority2 = @criticisms.where('tip_accept = ? or tip_reject = ? and tip_viewed = ?', 0, 0, 0).order("RANDOM()").first rescue nil
		
		@second_priority3 = @generals.where('tip_accept = ? or tip_reject = ? ', 1, 1 ).order("RANDOM()").first rescue nil
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
		@power = PowerGroup.where('email = ? and circle_name = ?', current_user.email, @priority.name) rescue nil
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
	   elsif params[:typee] == "criticism"
         @tip = Criticism.find(params[:id])
	   else  params[:typee] == "general"
	   	 @tip = General.find(params[:id])
	   end
	   	
		sum = 1
		user_view = 1
		#logic for decidind the tip is helpful or not
		if @tip.tip_accept >= 2
			@w = 1           #for deciding helpful tip
		elsif @tip.tip_reject >= 2 
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
		@tip.feedback = params[:suggestions]
		@tip.comment_quality = params[:quality_of_comments]
		@tip.tip_viewed = @tip.tip_viewed + user_view
		if params[:typee] == "praise"
         @tip.update_attributes(params[:praise])
	    elsif params[:typee] == "criticism"
         @tip.update_attributes(params[:criticism])
	    else  params[:typee] == "general"
	   	 @tip.update_attributes(params[:general])
	    end
		flash[:notice] = "Thanks for particiption."
		redirect_to helpful_tips_tips_path
	end

	def power_tips
		@tips = Tip.all
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
