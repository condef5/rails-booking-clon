require 'time'
puts "Init seed"

User.create(email: "drupvon@gmail.com", name:'condef5', password:'conde123', role:'admin')

User.create(email: "mperezzevallos@gmail.com", name:'marieth', password:'admin123', role:'admin')

user_normal = User.create(email: "drupvon+regular@gmail.com", name:'lucas', password:'regular', role:'regular')
user_normal2 = User.create(email: "p+regular@gmail.com", name:'lucas', password:'regular', role:'regular')

hotel = Hotel.create(name: 'Oro Verder',  email: 'drupvon+hotel@gmail.com',  city: 'Tingo Maria',  country: 'Peru',  address: 'Jr arequipa 440')
hotel2 = Hotel.create(name: 'Oro Verder',  email: 'p+hotel@gmail.com',  city: 'Tingo Maria',  country: 'Peru',  address: 'Jr arequipa 440')

hotel.rooms.create(name: 'Habitación simple', amount_of_beds: 1, price: 20)
hotel.rooms.create(name: 'Habitación doble', amount_of_beds: 2, price: 35)
hotel.rooms.create(name: 'Habitación matrimonial', amount_of_beds: 1, price: 40)
hotel.rooms.create(name: 'Suite', amount_of_beds: 2, price: 50)

hotel2.rooms.create(name: 'Habitación simple', amount_of_beds: 1, price: 20)

hotel.promotions.create(start_date: Date.parse('28-04-2019'), end_date: Date.parse('30-04-2019'), discount_type: 'percentage', discount_amount: '5')
hotel2.promotions.create(start_date: Date.parse('28-04-2019'), end_date: Date.parse('30-04-2019'), discount_type: 'percentage', discount_amount: '5')

Room.last.promotions.create(start_date: Date.parse('28-04-2019'), end_date: Date.parse('30-04-2019'), discount_type: 'fixed', discount_amount: '10')

user_normal.bookings.create(start_date: Date.parse('01-05-2019'), end_date: Date.parse('05-03-2019'), paid_price: 20, room_id: 1)
user_normal.bookings.create(start_date: Date.parse('06-03-2019'), end_date: Date.parse('05-04-2019'), paid_price: 20, room_id: 1)

user_normal.bookings.create(start_date: Date.parse('05-04-2019'), end_date: Date.parse('05-05-2019'), paid_price: 20, room_id: 1)
user_normal2.bookings.create(start_date: Date.parse('05-04-2019'), end_date: Date.parse('05-05-2019'), paid_price: 20, room_id: 2)

user_normal2.bookings.create(start_date: Date.parse('05-04-2019'), end_date: Date.parse('05-05-2019'), paid_price: 20, room_id: 5)

puts "Finished seed"
