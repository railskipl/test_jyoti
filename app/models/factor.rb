class Factor < ActiveRecord::Base
	attr_accessible :name, :circle_id
	belongs_to :circle
end
