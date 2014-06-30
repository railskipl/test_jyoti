class AdviceContact < ActiveRecord::Base
	attr_accessible :email, :praise, :criticism, :helpful_tips,:user_id
	validates_presence_of :email,:praise,:praise,:praise
end
