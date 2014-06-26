class Subscription < ActiveRecord::Base
 attr_accessible :email, :paypal_customer_token, :paypal_payment_token, :plan_id, :price, :user_id, :token,:name
  belongs_to :plan
  belongs_to :user
end
