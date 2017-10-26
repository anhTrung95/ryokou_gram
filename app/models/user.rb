class User < ActiveRecord::Base
  mount_uploader :avatar, AvatarUploader
  has_many :reviews, dependent: :destroy
  acts_as_voter
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
