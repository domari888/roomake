class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_tags, dependent: :destroy

  # user モデルの name を委譲する
  delegate :name, :avater, to: :user, prefix: true
end
