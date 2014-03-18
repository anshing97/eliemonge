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

  # Validate content type
  validates_attachment_content_type :image, :content_type => /\Aimage/

  # Validate filename
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]

  # Explicitly do not validate
  do_not_validate_attachment_file_type :image

end
