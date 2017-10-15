class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  acts_as_taggable_on :tags
  scope :order_desc, ->{order created_at: :desc}

  validates :user_id, presence: true
  validates :rate, presence: true
end
