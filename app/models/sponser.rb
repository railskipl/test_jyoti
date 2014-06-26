class Sponser < ActiveRecord::Base
    attr_accessible :name,:custom_factor,:user_id,:sponsercfs_attributes
	belongs_to :circle
	belongs_to :user
	has_many :sponsercfs
	accepts_nested_attributes_for :sponsercfs, limit: 10,  allow_destroy: true
	validates_uniqueness_of :name




	# def check_sponsercf_count
 #      if self.sponsercfs.count > 5
 #        self.errors.add :base, "No more than 5 sponser custom_factor allowed."
 #      end
 #   end

end
