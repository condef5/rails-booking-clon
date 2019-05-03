class PromotionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :start_date, :end_date, :discount_type, :discount_amount
end