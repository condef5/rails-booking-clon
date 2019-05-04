class BookingMailer < ApplicationMailer
  default from: 'notifications@myblog.com'

  def booking_deleted
    @user = User.find(params[:user])
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Booking deleted')
  end

  def booking_created_user
    @booking = params[:booking]
    mail(to: @booking.user.email, subject: 'Booking created')
  end

  def booking_created_hotel
    @booking = params[:booking]
    mail(to: @booking.room.hotel.email, subject: 'Booking created')
  end

  def reminder_booking_user
    @booking = params[:booking]
    mail(to: @booking.user.email, subject: 'Booking Reminder')
  end
end
