class SubscriptionsController < ApplicationController
	def new
  @subscription = Subscription.new(:user_id => params[:user_id], :token => params[:token], :price => params[:price], :plan_id=>params[:plan_id])
   plan = Plan.find(params[:plan_id])
   @subscription = plan.subscriptions.build
    if params[:PayerID]
      @subscription.user_id = params[:user_id]
      @subscription.price = params[:price]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
      @subscription.email = @subscription.paypal.checkout_details.email
    end
    
  end

 def create
    @subscription = Subscription.new(params[:subscription])
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end


   def plan
    @plans = Plan.all
    plan = Plan.find(params[:plan_id])
 
   end

  

  def update_with_paypal_payment(subscribe)
    response = paypal.make_recurring
    subscribe.update_attributes :plan_id => self.plan_id, :user_id => self.user_id, :email => self.email, :paypal_customer_token => self.paypal_customer_token, :paypal_recurring_profile_token => response.profile_id
  end

  
   def paypal_checkout
    plan = Plan.find(params[:plan_id])
    subscription = plan.subscriptions.build

    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url(:plan_id => plan.id,:user_id => current_user.id, :price => plan.price),
      cancel_url: root_url
    )
   end



   def show
     @subscription = Subscription.find_by(params[:plan_id])
   end


  
end
