class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table  :subscriptions do |t|
    	t.string  :email
    	t.string  :name
        t.integer :plan_id
        t.integer :user_id
        t.string  :paypal_customer_token
        t.string  :paypal_recurring_profile_token
        t.string  :token
        t.string  :price

      t.timestamps
    end
  end
end
