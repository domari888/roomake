class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validates :content, length: { maximum: 140 }
end
