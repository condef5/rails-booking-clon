# Documentation

## How to install

You need to install the Gemfile

```
bundle install
```

Now run the migrations and seeds

```
rails db:setup
```

Don't forget to add the `.env` file, copy a template from [.env.example](https://github.com/codeableorg/rails-booking-clon/blob/master/.env.example)

## This is the list user's

|  ROLE   |              EMAIL               | PASSWORD  |
| :-----: | :------------------------------: | :-------: |
|  ADMIN  |     davis.con.fab@gmail.com      | secret123 |
|  ADMIN  |        liamrn94@gmail.com        | secret123 |
|  ADMIN  |     mperezzevallos@gmail.com     | admin123  |
|  ADMIN  |      paulotijero@gmail.com       | admin123  |
| REGULAR | davis.con.fab+regular@gmail.com  | secret123 |
| REGULAR |    liamrn94+regular@gmail.com    | secret123 |
| REGULAR | mperezzevallos+regular@gmail.com |  regular  |
| REGULAR |  paulotijero+regular@gmail.com   |  regular  |

## This is a routes API's

| Prefix                      | Verb   | URI Pattern                                                      |
| :-------------------------- | :----- | :--------------------------------------------------------------- |
| api_login                   | POST   | /api/login(.:format)                                             |
| api_profile                 | GET    | /api/profile(.:format)                                           |
| api_users                   | GET    | /api/users(.:format)                                             |
|                             | POST   | /api/users(.:format)                                             |
| new_api_user                | GET    | /api/users/new(.:format)                                         |
| edit_api_user               | GET    | /api/users/:id/edit(.:format)                                    |
| api_user                    | GET    | /api/users/:id(.:format)                                         |
|                             | PATCH  | /api/users/:id(.:format)                                         |
|                             | PUT    | /api/users/:id(.:format)                                         |
|                             | DELETE | /api/users/:id(.:format)                                         |
| api_bookings                | GET    | /api/bookings(.:format)                                          |
|                             | POST   | /api/bookings(.:format)                                          |
| new_api_booking             | GET    | /api/bookings/new(.:format)                                      |
| edit_api_booking            | GET    | /api/bookings/:id/edit(.:format)                                 |
| api_booking                 | GET    | /api/bookings/:id(.:format)                                      |
|                             | PATCH  | /api/bookings/:id(.:format)                                      |
|                             | PUT    | /api/bookings/:id(.:format)                                      |
|                             | DELETE | /api/bookings/:id(.:format)                                      |
| api_hotel_promotions        | GET    | /api/hotels/:hotel_id/promotions(.:format)                       |
|                             | POST   | /api/hotels/:hotel_id/promotions(.:format)                       |
| new_api_hotel_promotion     | GET    | /api/hotels/:hotel_id/promotions/new(.:format)                   |
| edit_api_hotel_promotion    | GET    | /api/hotels/:hotel_id/promotions/:id/edit(.:format)              |
| api_hotel_promotion         | GET    | /api/hotels/:hotel_id/promotions/:id(.:format)                   |
|                             | PATCH  | /api/hotels/:hotel_id/promotions/:id(.:format)                   |
|                             | PUT    | /api/hotels/:hotel_id/promotions/:id(.:format)                   |
|                             | DELETE | /api/hotels/:hotel_id/promotions/:id(.:format)                   |
| api_hotel_room_bookings     | GET    | /api/hotels/:hotel_id/rooms/:room_id/bookings(.:format)          |
|                             | POST   | /api/hotels/:hotel_id/rooms/:room_id/bookings(.:format)          |
| new_api_hotel_room_booking  | GET    | /api/hotels/:hotel_id/rooms/:room_id/bookings/new(.:format)      |
| edit_api_hotel_room_booking | GET    | /api/hotels/:hotel_id/rooms/:room_id/bookings/:id/edit(.:format) |
| api_hotel_room_booking      | GET    | /api/hotels/:hotel_id/rooms/:room_id/bookings/:id(.:format)      |
|                             | PATCH  | /api/hotels/:hotel_id/rooms/:room_id/bookings/:id(.:format)      |
|                             | PUT    | /api/hotels/:hotel_id/rooms/:room_id/bookings/:id(.:format)      |
|                             | DELETE | /api/hotels/:hotel_id/rooms/:room_id/bookings/:id(.:format)      |
| api_hotel_rooms             | GET    | /api/hotels/:hotel_id/rooms(.:format)                            |
|                             | POST   | /api/hotels/:hotel_id/rooms(.:format)                            |
| new_api_hotel_room          | GET    | /api/hotels/:hotel_id/rooms/new(.:format)                        |
| edit_api_hotel_room         | GET    | /api/hotels/:hotel_id/rooms/:id/edit(.:format)                   |
| api_hotel_room              | GET    | /api/hotels/:hotel_id/rooms/:id(.:format)                        |
|                             | PATCH  | /api/hotels/:hotel_id/rooms/:id(.:format)                        |
|                             | PUT    | /api/hotels/:hotel_id/rooms/:id(.:format)                        |
|                             | DELETE | /api/hotels/:hotel_id/rooms/:id(.:format)                        |
| api_hotels                  | GET    | /api/hotels(.:format)                                            |
|                             | POST   | /api/hotels(.:format)                                            |
| new_api_hotel               | GET    | /api/hotels/new(.:format)                                        |
| edit_api_hotel              | GET    | /api/hotels/:id/edit(.:format)                                   |
| api_hotel                   | GET    | /api/hotels/:id(.:format)                                        |
|                             | PATCH  | /api/hotels/:id(.:format)                                        |
|                             | PUT    | /api/hotels/:id(.:format)                                        |
|                             | DELETE | /api/hotels/:id(.:format)                                        |
| api_room_promotions         | GET    | /api/rooms/:room_id/promotions(.:format)                         |
|                             | POST   | /api/rooms/:room_id/promotions(.:format)                         |
| new_api_room_promotion      | GET    | /api/rooms/:room_id/promotions/new(.:format)                     |
| edit_api_room_promotion     | GET    | /api/rooms/:room_id/promotions/:id/edit(.:format)                |
| api_room_promotion          | GET    | /api/rooms/:room_id/promotions/:id(.:format)                     |
|                             | PATCH  | /api/rooms/:room_id/promotions/:id(.:format)                     |
|                             | PUT    | /api/rooms/:room_id/promotions/:id(.:format)                     |
|                             | DELETE | /api/rooms/:room_id/promotions/:id(.:format)                     |
| book_api_room               | POST   | /api/rooms/:id/book(.:format)                                    |
| api_rooms                   | GET    | /api/rooms(.:format)                                             |
|                             | POST   | /api/rooms(.:format)                                             |
| new_api_room                | GET    | /api/rooms/new(.:format)                                         |
| edit_api_room               | GET    | /api/rooms/:id/edit(.:format)                                    |
| api_room                    | GET    | /api/rooms/:id(.:format)                                         |
|                             | PATCH  | /api/rooms/:id(.:format)                                         |
|                             | PUT    | /api/rooms/:id(.:format)                                         |
|                             | DELETE | /api/rooms/:id(.:format)                                         |
