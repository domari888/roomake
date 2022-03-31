class PostTag < ApplicationRecord
  belongs_to :post
  belongs_to :tag
  validates :post_id, uniqueness: {
    scope: :tag_id,
    message: 'ではすでにこのタグが選択されています'
  }
end
