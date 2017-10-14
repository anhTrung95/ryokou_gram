class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  scope :order_desc, ->{order created_at: :desc}

  validates :user_id, presence: true
  validates :rate, presence: true
end
