class SendBookingReminderNotificationJob < ApplicationJob
  queue_as :default

  def perform(booking)
    # Do something later
    BookingMailer.with(booking: booking).reminder_booking_user.deliver_later
  end
end
