class HotelQueries

  def most_popular
    Hotel.joins({:rooms => :bookings})
    .group('id')
    .order('count(bookings.id) DESC')
  end
  
end