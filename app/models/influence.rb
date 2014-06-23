class Influence < ActiveRecord::Base
	attr_accessible :your_influence,:influence_on_your,:email,:user_id,:power_groups_attributes
	has_many :user_invitations
	has_many :power_groups
	belongs_to :user
	belongs_to :circle
	accepts_nested_attributes_for :power_groups,  allow_destroy: true
	has_many :relationships
end
