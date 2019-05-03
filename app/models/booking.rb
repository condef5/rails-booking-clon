class Booking < ApplicationRecord
  belongs_to :room
  belongs_to :user
  after_create :notification_booking_created

  def self.available?(min_date, max_date)
    where('end_date >= ? AND start_date <= ?', min_date, max_date)
  end

  def notification_booking_created
    BookingMailer.with(booking: self).booking_created_user.deliver_later
    BookingMailer.with(booking: self).booking_created_hotel.deliver_later
  end

end
