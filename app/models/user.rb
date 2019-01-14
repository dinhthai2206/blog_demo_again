class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable, :omniauthable
  has_many :microposts, dependent: :destroy
  has_many :active_relationships,  class_name:  "Relationship",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :services, dependent: :destroy
  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum: 50}
  
  def feed
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Micropost.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
  end

  # Follows a user.
  def follow other_user
    following << other_user
  end

  # Unfollows a user.
  def unfollow other_user
    following.delete(other_user)
  end

  # Returns true if the current user is following the other user.
  def following? other_user
    following.include?(other_user)
  end

  def likes? micropost
    micropost.likes.where(user_id: id).any?
  end

  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #   unless user
  #     user = User.create(name: data['name'],
  #       email: data['email'],
  #       password: Devise.friendly_token[0,20]
  #       )
  #     user
  #   end
  # end

  protected

  def confirmation_required?
    false
  end
end
