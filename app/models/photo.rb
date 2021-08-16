class Photo < ApplicationRecord
  belongs_to :post
  validates :image, presence: true
  mount_upoader :image, ImageUploader
end
