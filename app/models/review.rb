class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  has_many :comments, dependent: :destroy
  acts_as_taggable_on :tags
  acts_as_votable
  scope :order_desc, ->{order created_at: :desc}
  scope :without_review, lambda{|review| review ? {:conditions => ["id != ?", review.id]} : {} }
  validates :user_id, presence: true
  validates :rate, presence: true
end
