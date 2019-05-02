require 'time'
puts "Init seed"

def get_image(file_name)
  { io: File.open(File.join(Rails.root, "/app/assets/images/seed#{file_name}")), filename: file_name }
end

hotels = [
  { 
    name: 'El viajero',
    email: 'drupvon+hotel4@gmail.com',
    city: 'Trujillo',
    country: 'Peru',
    address: 'Jr. Moche 550'
  },
  { 
    name: 'Green Paradise', 
    email: 'drupvon+hotel2@gmail.com',
    city: 'Huanuco',
    country: 'Peru',
    address: 'Jr. Ramones 140'
  },
  {
    name: 'Oro Verde',
    email: 'drupvon+hotel3@gmail.com',
    city: 'Pucallpa',
    country: 'Peru',
    address: 'Jr. Space 430'
  },
  { 
    name: 'Space',
    email: 'drupvon+hotel2@gmail.com',
    city: 'Huanuco',
    country: 'Peru',
    address: 'Jr. Ramones 140'
  },
]

rooms = [
  { name: 'Habitación simple', amount_of_beds: 1, price: 20, key: 'doble' },
  { name: 'Habitación doble', amount_of_beds: 1, price: 35, key: 'ejecutiva' },
  { name: 'Habitación matrimonial', amount_of_beds: 1, price: 40, key: 'matrimonial' },
  { name: 'Habitación suite', amount_of_beds: 2, price: 90, key: 'suite' }
]

# create hotels with rooms and promotions
hotels.each do |hotel|
  images = {
    image: get_image("/#{hotel[:name]}/main.jpg"),
    gallery: [
      get_image("/#{hotel[:name]}/gallery_1.jpg"),
      get_image("/#{hotel[:name]}/gallery_2.jpg"),
      get_image("/#{hotel[:name]}/gallery_3.jpg")
    ]
  }
  hotel = Hotel.create(hotel.merge(images))
  rooms.each do |room|
    rooms_images = {
      image: get_image("/#{hotel[:name]}/#{room[:key]}/main.jpg"),
      gallery: [
        get_image("/#{hotel[:name]}/#{room[:key]}/gallery_1.jpg"),
        get_image("/#{hotel[:name]}/#{room[:key]}/gallery_2.jpg"),
      ]
    }
    room.delete(:key)
    hotel.rooms.create(room.merge(rooms_images))
  end
  
  hotel.promotions.create(
    start_date: Date.parse('28-04-2019'),
    end_date: Date.parse('30-04-2019'),
    discount_type: ['percentage', 'fixed'].sample,
    discount_amount: rand(50) + 1
  )

  hotel.rooms.sample.promotions.create(
    start_date: Date.parse('28-04-2019'),
    end_date: Date.parse('30-04-2019'),
    discount_type: ['percentage', 'fixed'].sample,
    discount_amount: rand(50) + 1
  )
end

# create users
User.create(email: "davis.con.fab@gmail.com", name:'condef5', password:'secret123', role:'admin')
User.create(email: "davis.con.fab+regular@gmail.com", name:'desert', password:'secret123', role:'regular')
User.create(email: "liamrn94@gmail.com", name:'lian', password:'secret123', role:'admin')
User.create(email: "liamrn94+regular@gmail.com", name:'rlian', password:'secret123', role:'regular')
User.create(email: "mperezzevallos@gmail.com", name:'marieth', password:'admin123', role:'admin')
User.create(email: "mperezzevallos+regular@gmail.com", name:'lucas', password:'regular', role:'regular')
User.create(email: "paulotijero@gmail.com", name:'paulo', password:'admin123', role:'admin')
User.create(email: "paulotijero+regular@gmail.com", name:'rpaulo', password:'regular', role:'regular')

# create bookings
User.where(role: 'regular').all.each_with_index do |user, index|
  room = Hotel.find(index + 1).rooms.sample
  start_date = Date.today + rand(10)
  days = rand(10) + 1
  user.bookings.create(
    start_date: start_date,
    end_date: start_date + days,
    paid_price: days * room.price,
    room_id: room
  )
end

puts "Finished seed"

