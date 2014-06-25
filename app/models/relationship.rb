class Relationship < ActiveRecord::Base
	attr_accessible :your_influence,:influence_on_your,:email,:user_id,:influence_id,:circle_id,:how_well_you_know_the_person,:know_how_for_long_year,:know_how_for_long_month,:praise_tips,:criticism_tips,:helpful_tips,:well_known_user_avg,:how_long_you_know_each_other_avg,:influence_avg,:name,:custom_factor,:approve_custom_factor,:your_choise_custom_factor
	belongs_to :user
	belongs_to :circle
	belongs_to :power_groups
	belongs_to :factor
	belongs_to :user_invitation
	belongs_to :influence
	has_many :sponsees
end
