class CreateSponseeApprovals < ActiveRecord::Migration
  def change
    create_table :sponsee_approvals do |t|
      t.boolean :approve_custom_factor
      t.string :custom_factor
      t.string :your_choise_custom_factor

      t.timestamps
    end
  end
end
