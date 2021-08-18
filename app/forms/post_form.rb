class PostForm
  include ActiveModel::Model

  attr_accessor :content, :image, :current_user_id

  # Post モデルのバリデーション
  validates :content, presence: true, length: { maximum: 2000 }
  # Photo モデルのバリデーション
  validates :image, presence: true

  def save
    # バリデーションチェック
    return false if invalid?

    # 投稿を作成して、画像を保存
    post = Post.create!(content: content, user_id: current_user_id)
    post.photos.build(image: image).save!
  end
end