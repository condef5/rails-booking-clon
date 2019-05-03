class BookingsController < ApplicationController
  # List bookings for users in a table #9 
  def index
    @bookings = current_user.bookings
  end
end

