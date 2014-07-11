class AddSuggestionsToTips < ActiveRecord::Migration
  def change
    add_column :tips, :suggestions, :text
    add_column :tips, :quality_of_comments, :integer
  end
end
