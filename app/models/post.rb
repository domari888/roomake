class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destory
  validates :content, presence: true, length: { maximum: 2000 }
end
