class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image
  
  has_attached_file :image, 
    :styles => {
    :large => "900x600>",
    :medium => "600x400>",
    :square => "100x100#", 
    :small => "300x200>" 
  },
  :convert_options => { :all => '-auto-orient' }

  validates_attachment :image, :presence => true, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }

end
