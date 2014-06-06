class AddDetailsToUser < ActiveRecord::Migration
  def change

    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :sex, :string
    add_column :users, :birthday, :date
    add_column :users, :location, :string
    add_column :users, :organization, :string
    add_column :users, :industry, :string
    add_column :users, :secondary_email, :string
    add_column :users, :zip, :string
    add_column :users, :orgsize, :string

end
end
