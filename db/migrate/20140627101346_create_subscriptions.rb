class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :plan_id
      t.integer :user_id
      t.string :name
      t.string :email
      t.float :price
      t.string :paypal_payment_token
      t.string :paypal_customer_token
      t.string :paypal_recurring_profile_token
      t.string :token

      t.timestamps
    end
  end
end
