class BookingsController < ApplicationController
  # List bookings for users in a table #9 
  def index
    @bookings = current_user.bookings
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to bookings_path, notice: 'Booking was successfully destroyed.'
  end
end

