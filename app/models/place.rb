class Place < ActiveRecord::Base
    mount_uploader :overview, PlaceImageUploader
end
