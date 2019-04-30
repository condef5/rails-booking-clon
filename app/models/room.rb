class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable  , dependent: :destroy
  has_many :bookings

  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :amount_of_beds, numericality: { greater_than: 0 }
end
