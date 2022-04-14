class KnowHow < ApplicationRecord
  has_many :progresses, dependent: :destroy
  validates :genre, presence: true
  validates :title, presence: true
  validates :content, presence: true

  enum genre: { all_rooms: 1, kitchen: 2, toilet: 3, bath: 4, washbasin: 5, balcony: 6, entrance: 7 }

  def progressed_by?(current_user)
    progresses.any? { |progress| progress.user_id == current_user.id }
  end
end
