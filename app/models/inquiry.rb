class Inquiry < ApplicationRecord
  include Confirmable

  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true, length: { maximum: 48 }
  validates :name_kana, presence: true, format: { with: VALID_NAME_KANA_REGEX, message: 'は全角カタカナで入力してください' }, length: { maximum: 48 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, length: { maximum: 256 }
  validates :content, presence: true, length: { maximum: 2000 }
  validates :remote_ip, presence: true
end
