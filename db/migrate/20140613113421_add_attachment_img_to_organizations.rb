class AddAttachmentImgToOrganizations < ActiveRecord::Migration
 def self.up
  add_column :organizations, :img_file_name,    :string
  add_column :organizations, :img_content_type, :string
  add_column :organizations, :img_file_size,    :integer
  add_column :organizations, :img_updated_at,   :datetime
 end
 
 def self.down
 remove_column :organizations, :img_file_name
 remove_column :organizations, :img_content_type
 remove_column :organizations, :img_file_size
 remove_column :organizations, :img_updated_at
end
end
