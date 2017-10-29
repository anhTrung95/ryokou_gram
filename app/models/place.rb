class Place < ActiveRecord::Base
  mount_uploader :overview, PlaceImageUploader
  has_many :reviews, dependent: :destroy

  def update_point
    value = 0
    if self.reviews.exists?
      self.reviews.each do |v|
        value += v.rate
      end
    end
    update_attribute :point, value
  end
end
