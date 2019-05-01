class HotelSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :name, :email, :city, :country, :address, :image

  def image
    url_for(object.image) if self.object.image.attached?
  end
end