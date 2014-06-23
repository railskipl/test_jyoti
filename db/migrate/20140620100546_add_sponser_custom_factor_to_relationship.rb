class AddSponserCustomFactorToRelationship < ActiveRecord::Migration
  def change
    add_column :relationships, :good_coach, :text
    add_column :relationships, :empowers_team, :text
    add_column :relationships, :expresses_interest_concern, :text
    add_column :relationships, :productive_results_oriented, :text
    add_column :relationships, :good_communicator, :text
    add_column :relationships, :helps_with_career_development, :text
    add_column :relationships, :clear_vision_and_strategy, :text
    add_column :relationships, :uses_special_skills_to_advise, :text
    add_column :relationships, :romantic, :text
  end
end
