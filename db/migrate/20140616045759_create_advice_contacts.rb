class CreateAdviceContacts < ActiveRecord::Migration
  def change
    create_table :advice_contacts do |t|
      t.string :email
      t.text :praise
      t.text :criticism
      t.text :helpful_tips

      t.timestamps
    end
  end
end
