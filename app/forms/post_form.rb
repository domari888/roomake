class PostForm
  include ActiveModel::Model

  attr_accessor :content, :image, :post, :tag_ids, :category_ids, :delete_ids, :user_id

  # Post モデルのバリデーション
  validates :content, presence: true, length: { maximum: 2000 }
  # Photo モデルのバリデーション
  validates :image, presence: true, on: :create
  validates :image, image_length: true

  validates :tag_ids, presence: true, length: { maximum: 2 }, custom_numericality: { allow_blank: true }
  validates :category_ids, presence: true, length: { maximum: 2 }, custom_numericality: { allow_blank: true }

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      if post.persisted?
        post_update
      else
        post_create
      end
    end
  end

  private

  def post_update
    if delete_ids.present?
      delete_ids.each do |id|
        Photo.find(id.to_i).destroy!
      end
    end
    if image.present?
      image.each do |img|
        post.photos.build(image: img).save!
      end
    end
    raise ActiveRecord::Rollback unless post.photos.any?

    post.update!(content: content, tag_ids: tag_ids, category_ids: category_ids)
  end

  def post_create
    post = Post.new(content: content, user_id: user_id, tag_ids: tag_ids, category_ids: category_ids)
    return false if image.blank?

    image.each do |img|
      post.photos.build(image: img).save!
    end
  end
end
