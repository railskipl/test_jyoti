json.array!(@subscriptions) do |subscription|
  json.extract! subscription, :id, :plan_id, :user_id, :name, :email, :price, :paypal_payment_token, :paypal_customer_token, :paypal_recurring_profile_token, :token
  json.url subscription_url(subscription, format: :json)
end
