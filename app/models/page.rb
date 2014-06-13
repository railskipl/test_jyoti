class Page < ActiveRecord::Base
	  attr_accessible :title, :body, :photo,:status
	  has_attached_file  :photo,:styles => { :thumb => "176x100", :medium => "480x270>", :profile => "130x126"}
	  validates_attachment :photo, content_type: { content_type: ['image/jpeg', 'image/GIF'] }
	  validates_presence_of :title
end
