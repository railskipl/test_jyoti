class AddAttachmentPhotoToPages < ActiveRecord::Migration
  def self.up
    change_table :pages do |t|
      t.attachment :photo
    end
  end

  def self.down
    drop_attached_file :pages, :photo
  end
end
