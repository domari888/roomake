class PostForm
  include ActiveModel::Model

  attr_accessor :content, :images, :post, :tag_ids, :category_ids, :delete_ids, :user_id

  # Post モデルのバリデーション
  validates :content, presence: true, length: { maximum: 2000 }
  # Photo モデルのバリデーション
  validates :images, presence: true, on: :create
  validates :images, number_of_images: true

  validates :tag_ids, presence: true, length: { maximum: 2, message: 'は最大2つまで選択できます' }, custom_numericality: { allow_blank: true }
  validates :category_ids, presence: true, length: { maximum: 2, message: 'は最大2つまで選択できます' }, custom_numericality: { allow_blank: true }

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      if post.persisted?
        post_update
      else
        post_create
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, message: e.record.errors.full_messages)
    false
  end

  private

  def post_update
    if delete_ids.present?
      delete_ids.each do |id|
        Photo.find(id.to_i).destroy!
      end
    end
    if images.present?
      images.each do |img|
        post.photos.build(image: img).save!
      end
    end
    raise ActiveRecord::Rollback unless post.photos.any?

    post.update!(content: content, tag_ids: tag_ids, category_ids: category_ids)
  end

  def post_create
    post = Post.new(content: content, user_id: user_id, tag_ids: tag_ids, category_ids: category_ids)
    return false if images.blank?

    images.each do |img|
      post.photos.build(image: img).save!
    end
  end
end
