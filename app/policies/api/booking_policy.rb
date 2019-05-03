class Api::BookingPolicy < ApplicationPolicy
  attr_reader :user, :booking

  def initialize(user, booking)
    @user = user
    @booking = booking
  end

  def index?
    user.has_role?('regular') || user.has_role?('admin')
  end

  def show?
    booking.user.id == user.id || user.has_role?('admin')
  end

  def create?
    user.has_role?('regular')
  end

  def update?
    (user.has_role?('regular') && booking.user.id == user.id) || user.has_role?('admin')
  end

  def destroy?
    (user.has_role?('regular') && booking.user.id == user.id) || user.has_role?('admin')
  end
end 
