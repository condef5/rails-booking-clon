class RoomSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :amount_of_beds, :hotel_id, :price, :image
  
  def image
    url_for(object.image) if self.object.image.attached?
  end
  
end