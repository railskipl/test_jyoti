class Subscription < ActiveRecord::Base
 attr_accessible :email, :paypal_customer_token, :paypal_payment_token, :plan_id, :price, :user_id, :token,:name
  belongs_to :plan
  belongs_to :user

   attr_accessor :paypal_payment_token

  def save_with_payment
    
     if valid?
       if paypal_payment_token.present?

        subscription = Subscription.find_by_email(self.email) rescue nil
        if subscription.present?
          (update_with_paypal_payment(subscription)) && (update_user(user))
        else
            save_with_paypal_payment
          end
       else
         # raise paypal_payment_token.inspect
         #save_with_stripe_payment
       end
     end
   end


  def paypal
    PaypalPayment.new(self)
  end


  def update_with_paypal_payment(subscribe)
    response = paypal.make_recurring
    subscribe.update_attributes :plan_id => self.plan_id, :user_id => self.user_id, :email => self.email, :paypal_customer_token => self.paypal_customer_token, :paypal_recurring_profile_token => response.profile_id
  end


  def update_user(user)
  user.update_attributes(:plan_id => self.plan_id)
  end


  def save_with_paypal_payment
    response = paypal.make_recurring
    self.paypal_recurring_profile_token = response.profile_id
    save!
  end


def payment_provided?
    paypal_payment_token.present?
  end


end

  