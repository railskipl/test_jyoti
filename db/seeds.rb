# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
	# Role.create(:name => "admin")
	# Role.create(:name => "user")
	# Role.create(:name => "subuser")


	# admin = User.create(:username => 'admin', :email=> 'admin@gmail.com', :password => 'admin123', :firstname => "admin",
	# :lastname => "padmin",:confirmed_at => Date.today)
	#      admin.roles = [Role.first]
	#      admin.save


 User.where(:email => "admin@gmail.com",:password => "admin123",:is_admin => true,:confirmed_at => Date.today).first_or_create

 # Plan.where(:price => 0.0).first_or_create
 # Plan.where(:price => 25).first_or_create
 # Plan.where(:price => 50).first_or_create
 # Plan.where(:price => 100).first_or_create
 # Plan.where(:price => 200).first_or_create
 # Plan.where(:price => 300).first_or_create


#  Plan.create(:name => "Applaud", :price => "0.50")
# Plan.create(:name => "Award", :price => "0.50")
#    Plan.create(:name => "Alloy", :price => "1.00")