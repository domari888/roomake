class Home < ApplicationRecord
  validates :title, presence: true
  validates :subtitle, presence: true
  validates :image, presence: true
  validates :content, presence: true

  mount_uploader :image, ImageUploader
end
