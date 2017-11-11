class PlacePhoto < ActiveRecord::Base
  mount_uploader :photo, PlaceImageUploader
  belongs_to :place

  existed_photo = lambda do |id|
    where "place_id = #{id}"
  end
  scope :existed_photo, existed_photo
end
