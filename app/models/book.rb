class Book < ActiveRecord::Base
  has_attached_file :cover_image, 
    :styles => { 
      :standard => "1024x1024>",
      :thumb => "72x72>" 
    },
    :default_url => "/images/book/:style/blank.png"
																															
  validates_attachment_content_type :cover_image, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :cover_image, :less_than => 2.megabytes
end
