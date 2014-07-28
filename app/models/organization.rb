class Organization < ActiveRecord::Base
	attr_accessible :title, :body, :img,:status


	HOW_HEARD_OPTIONS = [ 
    'Advertising and Marketing',
    'Agriculture',
    'Airlines and aerospace(including defense)',
    'Automotive',
    'Business Support and Logostics',
    'Constriction, Machinery and Home',
    'Education',
    'Entertainment and leisure',
    'Finance and Financial Services',
    'Food And Beverages',
    'Government',
    'Health care and pharmaceuticals',
    'Insurance',
    'Manufacturing',
    'Nonprofit',
    'Retails And Consumer Durables',
    'Real Estate',
    'Telecommunication, Technology, Internet and Electronics',
    'Utilities , Energy and Extraction'
  ]




  Organization_size = [ 
    '1-4',
    '5-9',
    '10-19',
    '20-99',
    '100-499',
    '500-749',
    '750-999',
    '1,000-1,499',
    '1,500-1,999',
    '2,000-2,499',
    '2,500-4,999',
    '5,000-9,999',
    '10,000 or more'
  ]
  
end
