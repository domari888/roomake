class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, presence: true, length: { maximum: 140 }

  # user  モデルの name と avater を委譲する
  delegate :name, :avater, to: :user, prefix: true
end
