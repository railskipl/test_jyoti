class ScoreFactor < ActiveRecord::Base
	attr_accessible :name, :description,:factor_type
	validates :name, :uniqueness => {:scope => :factor_type }
end
