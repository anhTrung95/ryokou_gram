class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place

  has_many :comments, dependent: :destroy

  acts_as_taggable_on :tags
  acts_as_votable

  scope :order_desc, ->{order created_at: :desc}
  scope :without_review, lambda{|review| review ? {:conditions => ["id != ?", review.id]} : {} }
  scope :load_review_with_content, ->(review_content){where "content LIKE ?",
    "%#{review_content}%"}

  validates :user_id, presence: true
  validates :rate, presence: true

  find_feed_item = lambda do |id|
    where "user_id IN (SELECT followed_id FROM relationships
      WHERE follower_id = #{id}) OR user_id = #{id}"
  end
  scope :find_feed_item, find_feed_item

  find_follow_item = lambda do |id|
    where "user_id IN (SELECT followed_id FROM relationships
      WHERE follower_id = #{id})"
  end
  scope :find_follow_item, find_follow_item
end
