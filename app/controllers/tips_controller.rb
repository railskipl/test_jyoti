class TipsController < ApplicationController

 before_filter :authenticate_user!
 before_filter :check_user, only: [:new,:index]

def index
  @users = User.all
  #@emails = Email.all
  @tips = Tip.all
end

def new
 @tip = Tip.new
end

def create
 @tip = Tip.new(params[:tip])
    if @tip.save
     redirect_to :back, notice: "Tips has been provided to this particular."
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


private
    # Use callbacks to share common setup or constraints between actions.

    def check_user
      if user_signed_in?
      else
        redirect_to root_path, :alert => "Unauthorised Access"
      end
     
    end


end
