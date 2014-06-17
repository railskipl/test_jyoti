class AddEmailToInfluence < ActiveRecord::Migration
  def change
    add_column :influences, :email, :string
  end
end
