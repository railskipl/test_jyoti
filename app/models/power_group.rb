class PowerGroup < ActiveRecord::Base
	attr_accessible :your_influence,:influence_on_your,:email,:user_id,:influence_id
	belongs_to :influence
end
