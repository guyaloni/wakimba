class AddCoverToBook < ActiveRecord::Migration
  def change
  	add_attachment :books, :cover_image
  end
end
