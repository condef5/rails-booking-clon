class Hotel < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :promotions, as: :promotionable , dependent: :destroy
  has_many :bookings, through: :rooms
end
