class SubscriptionsController < ApplicationController
  before_action  only: [:show, :edit, :update, :destroy]

  # GET /subscriptions
  # GET /subscriptions.json
  def index
    @subscriptions = Subscription.all
  end

  # GET /subscriptions/1
  # GET /subscriptions/1.json
  def show
    @subscription = Subscription.find_by_plan_id(params[:id])
  end

  # GET /subscriptions/new
  # def new
  #   @subscription = Subscription.new
  # end

 
  

  def new
  @subscription = Subscription.new(:user_id => params[:user_id], :token => params[:token], :price => params[:price], :name => params[:name])
      plan = Plan.find(params[:plan_id])    
      
      @subscription = plan.subscriptions.build
      if params[:PayerID]
      @subscription.user_id = params[:user_id]
      @subscription.price = params[:price]
      @subscription.name = params[:name]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email

      end

     if @subscription.save_with_payment
      redirect_to plans_path, :id => @subscription.plan_id
     else
      render :new
     end
 end

  # GET /subscriptions/1/edit
  def edit
  end

  

  # PATCH/PUT /subscriptions/1
  # PATCH/PUT /subscriptions/1.json
  # def update
  #   respond_to do |format|
  #     if @subscription.update(subscription_params)
  #       format.html { redirect_to @subscription, notice: 'Subscription was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @subscription }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @subscription.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def update
    @subscription = current_user.subscription
     if @subscription.update_stripe
      redirect_to edit_subscription_path, :success => 'Updated Card.'
    else
      flash.alert = 'Unable to update card.'
      render :edit
    end
  end



  # DELETE /subscriptions/1
  # DELETE /subscriptions/1.json
  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html { redirect_to subscriptions_url, notice: 'Subscription was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build
    user = User.find_by_id(params[:user_id])
    user = Plan.find_by_name(params[:name])
    
      redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url(:plan_id => plan.id,:user_id => current_user.id, :price => plan.price, :name => plan.name),
      cancel_url: root_url
      )
  
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def subscription_params
      params.require(:subscription).permit(:plan_id, :user_id, :name, :email, :price, :paypal_payment_token, :paypal_customer_token, :paypal_recurring_profile_token, :token)
    end

    def paypal
      PaypalPayment.new(self)
    end
end
