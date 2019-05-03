class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user

  def self.available?(min_date, max_date)
    where('end_date >= ? AND start_date <= ?', min_date, max_date)
  end
end
