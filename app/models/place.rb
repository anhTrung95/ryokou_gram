class Place < ActiveRecord::Base
    mount_uploader :overview, PlaceImageUploader
    has_many :reviews, dependent: :destroy
end
