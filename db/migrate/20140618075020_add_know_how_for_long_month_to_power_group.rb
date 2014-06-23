class AddKnowHowForLongMonthToPowerGroup < ActiveRecord::Migration
  def change
    add_column :power_groups, :know_how_for_long_month, :integer
  end
end
