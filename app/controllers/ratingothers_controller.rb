class RatingothersController < ApplicationController
  # before_filter :check_user, only: [:new]

 def index
  
 end

 def new
  @ratingother = Ratingother.new
 end

# def create
 
#  @ratingother = Ratingother.new(params[:ratingother])

  
#   unless @ratingother.email.empty?

#     if @ratingother.save
#       flash[:notice] = "Rating has been done."
#       redirect_to encourage_signing_up_ratingothers_path
#     else
#       render 'new'
#     end 
#   else
#     flash[:notice] = "No email found."
#     redirect_to new_ratingother_path  
#   end
# end

def create
 
 @ratingother = Ratingother.new(params[:ratingother])
 
  unless @ratingother.anonymous_user 
    if @ratingother.email.empty? 
       flash[:notice] = "No user found."
       redirect_to new_ratingother_path
    else
      @user = User.where('email = ?', @ratingother.email) rescue nil
      if @user.present?
        @ratingother.friend_id = @user[0].id
      end
        #for onbording sequence ratings other
        if user_signed_in?
          @reputation = AccessReputationTip.where('user_id = ?', current_user.id)
          if @reputation
            a = 1
            @reputation.first.give_ratings = @reputation.first.give_ratings + 1
            @reputation.first.update_attributes(params[:access_reputation_tip])
          end
        end
        
        if @ratingother.save
          redirect_to :root, notice: "Rating has been done."
        else
          render 'new'
        end
    end
  else

    if @ratingother.save
      flash[:notice] = "Rating has been done."
      redirect_to :root
    else
      render 'new'
    end 
  end
end

def failure
  
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
