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


  require 'csv'

        puts "Importing countries..."
        CSV.foreach(Rails.root.join("countries.csv"), headers: true) do |row|
          Country.create! do |country|
            country.id = row[0]
            country.name = row[1]
          end
        end
 # Plan.where(:price => 0.0).first_or_create
 # Plan.where(:price => 25).first_or_create
 # Plan.where(:price => 50).first_or_create
 # Plan.where(:price => 100).first_or_create
 # Plan.where(:price => 200).first_or_create
 # Plan.where(:price => 300).first_or_create


#  Plan.create(:name => "Applaud", :price => "0.50")
# Plan.create(:name => "Award", :price => "0.50")
#    Plan.create(:name => "Alloy", :price => "1.00")


# Afghanistan
# Albania
# Algeria
# Andorra
# Angola
# Antigua & Deps
# Argentina
# Armenia
# Australia
# Austria
# Azerbaijan
# Bahamas
# Bahrain
# Bangladesh
# Barbados
# Belarus
# Belgium
# Belize
# Benin
# Bhutan
# Bolivia
# Bosnia Herzegovina
# Botswana
# Brazil
# Brunei
# Bulgaria
# Burkina
# Burundi
# Cambodia
# Cameroon
# Canada
# Cape Verde
# Central African Rep
# Chad
# Chile
# China
# Colombia
# Comoros
# Congo
# Congo {Democratic Rep}
# Costa Rica
# Croatia
# Cuba
# Cyprus
# Czech Republic
# Denmark
# Djibouti
# Dominica
# Dominican Republic
# East Timor
# Ecuador
# Egypt
# El Salvador
# Equatorial Guinea
# Eritrea
# Estonia
# Ethiopia
# Fiji
# Finland
# France
# Gabon
# Gambia
# Georgia
# Germany
# Ghana
# Greece
# Grenada
# Guatemala
# Guinea
# Guinea-Bissau
# Guyana
# Haiti
# Honduras
# Hungary
# Iceland
# India
# Indonesia
# Iran
# Iraq
# Ireland {Republic}
# Israel
# Italy
# Ivory Coast
# Jamaica
# Japan
# Jordan
# Kazakhstan
# Kenya
# Kiribati
# Korea North
# Korea South
# Kosovo
# Kuwait
# Kyrgyzstan
# Laos
# Latvia
# Lebanon
# Lesotho
# Liberia
# Libya
# Liechtenstein
# Lithuania
# Luxembourg
# Macedonia
# Madagascar
# Malawi
# Malaysia
# Maldives
# Mali
# Malta
# Montenegro
# Marshall Islands
# Mauritania
# Mauritius
# Mexico
# Micronesia
# Moldova
# Monaco
# Mongolia
# Morocco
# Mozambique
# Myanmar, {Burma}
# Namibia
# Nauru
# Nepal
# Netherlands
# New Zealand
# Nicaragua
# Niger
# Nigeria
# Norway
# Oman
# Pakistan
# Palau
# Panama
# Papua New Guinea
# Paraguay
# Peru
# Philippines
# Poland
# Portugal
# Qatar
# Romania
# Russian
# Rwanda
# St Kitts & Nevis
# St Lucia
# Saint Vincent & the Grenadines
# Samoa
# San Marino
# Sao Tome & Principe
# Saudi Arabia
# Senegal
# Serbia
# Seychelles
# Sierra Leone
# Singapore
# Slovakia
# Slovenia
# Solomon Islands
# Somalia
# South Africa
# Spain
# Sri Lanka
# Sudan
# Suriname
# Swaziland
# Sweden
# Switzerland
# Syria
# Taiwan
# Tajikistan
# Tanzania
# Thailand
# Togo
# Tonga
# Trinidad & Tobago
# Tunisia
# Turkey
# Turkmenistan
# Tuvalu
# Uganda
# Ukraine
# United Arab Emirates
# United Kingdom
# United States
# Uruguay
# Uzbekistan
# Vanuatu
# Vatican City
# Venezuea
# Vietnam
# Yemen
# Zambia
# Zimbabwe


ScoreFactor.create(:name => "trustworthy", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "trustworthy", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "kind_helpful", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "kind_helpful", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "potential", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "potential", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "presentable", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "presentable", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "perform_well", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "perform_well", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "emotianally_mature", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "emotianally_mature", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "friendly_social", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "friendly_social", :description => "Test", :factor_type => "raise")

ScoreFactor.create(:name => "recency", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "recency", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "history", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "history", :description => "Test", :factor_type => "raise")
ScoreFactor.create(:name => "diversity", :description => "Test", :factor_type => "low")
ScoreFactor.create(:name => "diversity", :description => "Test", :factor_type => "raise")