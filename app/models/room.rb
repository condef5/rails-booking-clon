class Room < ApplicationRecord
  belongs_to :hotel
  has_many :promotions, as: :promotionable  , dependent: :destroy
  has_many :bookings, dependent: :destroy
  has_one_attached :image
  has_many_attached :gallery


  validates :name, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :amount_of_beds, numericality: { greater_than: 0 }

  def discount
    paid_price = price
    if promotions.any?
      promotions.each do |promotion|
        if promotion.start_date <= Date.today && promotion.end_date >= Date.today
          if promotion.discount_type == 'percentage'
            paid_price = ((1 - promotion.discount_amount.to_f / 100) * paid_price).to_i
          else
            paid_price = paid_price - promotion.discount_amount
          end
        end
      end
    end
    paid_price
  end
end
