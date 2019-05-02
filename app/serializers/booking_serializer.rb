class BookingSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :start_date, :end_date, :paid_price, :room_id, :user_id
end