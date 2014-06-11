class AddStatusToPages < ActiveRecord::Migration
  def change
    add_column :pages, :status, :boolean,:default =>false
  end
end
