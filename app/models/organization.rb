class Organization < ActiveRecord::Base
	attr_accessible :title, :body, :img,:status


	HOW_HEARD_OPTIONS = [ 
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]




  Organization_size = [ 
    'Newsletter',
    'Blog Post',
    'Twitter',
    'Web Search',
    'Friend/Coworker',
    'Other'
  ]
  
  validates :how_heard, inclusion: { in: HOW_HEARD_OPTIONS }
end
