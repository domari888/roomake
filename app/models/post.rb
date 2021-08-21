class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  validates :content, presence: true, length: { maximum: 2000 }

# user モデルの name を委譲する
  delegate :name, :avater, to: :user, prefix: true
end