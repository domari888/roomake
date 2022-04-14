class Progress < ApplicationRecord
  belongs_to :user
  belongs_to :know_how
  validates :user_id, uniqueness: {
    scope: :know_how_id,
    message: 'は同じノウハウに2回以上チェックはできません'
  }
end
