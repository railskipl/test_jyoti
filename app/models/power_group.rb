class PowerGroup < ActiveRecord::Base
	attr_accessible :your_influence,:influence_on_your,:email,:user_id,:influence_id,:circle_id,:how_well_you_know_the_person,:know_how_for_long_year,:know_how_for_long_month,:praise_tips,:criticism_tips,:helpful_tips,
	                :circle_name
	belongs_to :influence
	belongs_to :circle
	belongs_to :tip
	has_many :relationships



end
