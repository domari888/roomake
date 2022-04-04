class Item < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validate :unique_item?, if: -> { user_id.present? }

  def unique_item?
    user = User.find(user_id)
    return unless user.items.find_by(name: name)

    errors.add(:name, 'は既に登録されています')
  end
end
