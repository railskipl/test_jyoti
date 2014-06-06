class CreateMailers < ActiveRecord::Migration
  def change
    create_table :mailers do |t|

      t.timestamps
    end
  end
end
