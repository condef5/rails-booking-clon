class BookingMailer < ApplicationMailer
  default from: 'notifications@myblog.com'

  def booking_deleted
    @user = User.find(params[:user])
    @booking = params[:booking]
    mail(to: @user.email, subject: 'Booking deleted')
  end
end
