class AddAttachmentToImage < ActiveRecord::Migration
  def change
    add_attachment :images, :image
  end
  def self.down
    remove_attachment :images, :image
  end
end
