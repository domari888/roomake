class PostForm
  include ActiveModel::Model

  attr_accessor :content, :image, :current_user_id, :post

  # Post モデルのバリデーション
  validates :content, presence: true, length: { maximum: 2000 }
  # Photo モデルのバリデーション
  validates :image, presence: true

  def save
    # バリデーションチェック
    return false if invalid?

    # 投稿が存在する場合、投稿内容とその画像を更新
    ActiveRecord::Base.transaction do
      if @post.persisted?
        @post.photos.delete_all
        @post.update!(content: content, user_id: current_user_id)
      else
        # 投稿を作成して、画像を保存
        @post = Post.new(content: content, user_id: current_user_id)
      end
      @post.photos.build(image: image).save!
    end
  end
end
