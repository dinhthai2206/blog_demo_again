class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  validates :user_id, presence: true
  validates :title, presence: true, length: {maximum: 60}
  validates :content, presence: true
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  default_scope -> {order(created_at: :desc)}
  
  private

  # Validates the size of an uploaded picture.
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
