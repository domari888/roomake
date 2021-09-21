class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  # user モデルの name を委譲する
  delegate :name, :avater, to: :user, prefix: true
end
