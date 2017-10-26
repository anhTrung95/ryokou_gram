class Place < ActiveRecord::Base
    mount_uploader :overview, PlaceImageUploader
    has_many :reviews, dependent: :destroy

    def update_point value
      update_attribute :point, value
    end
end
