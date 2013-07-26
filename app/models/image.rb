class Image < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :image
  has_attached_file :image

end
