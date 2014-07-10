class TipsController < ApplicationController

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
  
    if @tip.save

      if params[:tip][:rating] == "true"
        redirect_to new_ratingother_path(:email => @tip.email), notice: "Tips has been provided to particular."
      else
        redirect_to my_mirror_paste_users_path, notice: "Tips has been provided to this particular user."

      end
    else
      render 'new'
    end
	
end

def destroy
    @tip = Tip.find(params[:id])
    @tip.destroy
    redirect_to tips_path
  end


  def merge_email
  	@merge_email =User.find(params[:id])
  end

  def demerge_email
  end

  def helpful_tips
    @users = User.all
    @response_tip = ResponseTip.all
    #@tips = Tip.all
    @tips = Tip.where('user_id != ?', current_user.id)
    @tipss = @tips.where('email != ?', current_user.email)
    @a = @tipss.order("RANDOM()").first
    @power = PowerGroup.where('email = ? and circle_name = ?', current_user.email, @a.name)
    if @power.empty?
     @ww = @a
    end
  
  end

  def tips_response
    @tip = Tip.find(params[:id])
    sum = 1
    if params[:response] == "true"
      @sum = @tip.tip_accept + sum
      @tip.tip_accept = @sum
      @tip.update_attributes(params[:tip])
      flash[:notice] = "Thanks for particiption."
      redirect_to :back
    else
      @sum = @tip.tip_reject + sum
      @tip.tip_reject = @sum
      @tip.update_attributes(params[:tip])
      flash[:notice] = "Thanks for particiption."
      redirect_to :back
    end
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
