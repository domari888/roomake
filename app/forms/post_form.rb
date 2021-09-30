class PostForm
  include ActiveModel::Model

  attr_accessor :content, :image, :current_user_id, :post, :tag_ids, :category_ids

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
      image.each do |image|
        @post.photos.build(image: image).save!
      end
      tag_ids.each do |tag_id|
        @post.post_tags.build(tag_id: tag_id).save!
      end
      category_ids.each do |category_id|
        @post.post_categories.build(category_id: category_id).save!
      end
    end
  end
end
