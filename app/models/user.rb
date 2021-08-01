class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { maximum: 30 }
  validates :age, presence: true
  validates :address, presence: true
  validates :profile, length: { maximum: 2000 }
  validates :household, presence: true
end
