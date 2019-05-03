class BookingSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date, :paid_price, :room_id, :user_id
end
