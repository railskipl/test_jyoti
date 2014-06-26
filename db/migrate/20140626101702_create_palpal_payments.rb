class CreatePalpalPayments < ActiveRecord::Migration
  def change
    create_table :palpal_payments do |t|

      t.timestamps
    end
  end
end
