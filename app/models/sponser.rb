class Sponser < ActiveRecord::Base
    attr_accessible :name,:custom_factor,:user_id,:sponsercfs_attributes
	belongs_to :circle
	belongs_to :user
	has_many :sponsercfs
	accepts_nested_attributes_for :sponsercfs,  allow_destroy: true
end
