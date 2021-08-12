class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
  validates :age, presence: true
  validates :address, presence: true
  validates :profile, length: { maximum: 2000 }
  validates :household, presence: true

  # AvaterUploader と users テーブルの avater カラムを連携
  mount_uploader :avater, AvaterUploader

  enum age: {
    teens: 1,
    twenties: 2,
    thirties: 3,
    forties: 4,
    fifties: 5,
    sixties: 6,
    others: 7
  }

  enum address: {
    hokkaido: 1,
    aomori: 2,
    iwate: 3,
    miyagi: 4,
    akita: 5,
    yamagata: 6,
    fukushima: 7,
    ibaraki: 8,
    tochigi: 9,
    gunma: 10,
    saitama: 11,
    chiba: 12,
    tokyo: 13,
    kanagawa: 14,
    niigata: 15,
    toyama: 16,
    ishikawa: 17,
    fukui: 18,
    yamanashi: 19,
    nagano: 20,
    gifu: 21,
    shizuoka: 22,
    aichi: 23,
    mie: 24,
    shiga: 25,
    kyoto: 26,
    osaka: 27,
    hyogo: 28,
    nara: 29,
    wakayamaiwate: 30,
    tottoriiwate: 31,
    shimaneiwate: 32,
    okayamaiwate: 33,
    hiroshimaiwate: 34,
    yamaguchiiwate: 35,
    tokushimaiwate: 36,
    kagawaiwate: 37,
    ehimeiwate: 38,
    kochiiwate: 39,
    fukuoka: 40,
    saga: 41,
    nagasaki: 42,
    kumamoto: 43,
    oita: 44,
    miyazaki: 45,
    kagoshima: 46,
    okinawa: 47
  }

  enum household: {
    single_household: 1,
    two_person_household: 2,
    three_person_household: 3,
    four_person_household: 4,
    five_person_household: 5,
    others_household: 6
  }
end
