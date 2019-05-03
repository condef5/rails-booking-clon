class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :promotions, as: :promotionable , dependent: :destroy
  has_many :bookings, through: :rooms
  has_one_attached :image
  has_many_attached :gallery
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :city, presence: true
  validates :country, presence: true
  validates :address, presence: true
end
