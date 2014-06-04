class Page < ActiveRecord::Base
	  attr_accessible :title, :body, :photo
	  has_attached_file :photo, :styles => { :small => "150x150>" }
      do_not_validate_attachment_file_type :photo
end
