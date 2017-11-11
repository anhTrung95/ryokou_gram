class Place < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  has_many :place_photos, dependent: :destroy

  scope :load_place_with_name, ->(name){where "name LIKE ?", "%#{name}%"}

  accepts_nested_attributes_for :place_photos

  def update_point
    value = 0
    if self.reviews.exists?
      self.reviews.each do |v|
        value += v.rate
      end
    end
    update_attribute :point, value
  end

  def exist_photo
    PlacePhoto.existed_photo id
  end
end
