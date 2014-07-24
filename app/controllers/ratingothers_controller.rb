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
 
 @user = User.where('email = ?', @ratingother.email)
  unless @ratingother.anonymous_user 
    if @ratingother.email.empty? || @user.empty? || @user[0].email == current_user.email
       flash[:notice] = "No user found."
       redirect_to new_ratingother_path
    else
      @user = User.where('email = ?', @ratingother.email)
      @ratingother.friend_id = @user[0].id
      @rating_exist = Ratingother.where('user_id = ? and friend_id = ?', @ratingother.user_id, @ratingother.friend_id)

      if @rating_exist.empty?
        if @ratingother.save
          redirect_to :back, notice: "Rating has been done."
        else
          render 'new'
        end
      else
        flash[:notice] = "You have already rated this user."
        redirect_to new_ratingother_path
      end
    end
  else
    @user = User.where('email = ?', @ratingother.email)
    unless @user
      flash[:notice] = "No user found."
      redirect_to new_ratingother_path
    else
      if @ratingother.save
        flash[:notice] = "Rating has been done."
        redirect_to :root
      else
        render 'new'
      end
    end
  end
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
