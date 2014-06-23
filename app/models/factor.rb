class Factor < ActiveRecord::Base
	attr_accessible :custom_factor, :circle_id
	belongs_to :circle
	has_many :relationships
end
