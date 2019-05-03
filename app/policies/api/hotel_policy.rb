class Api::HotelPolicy
  attr_reader :user, :hotel

  def initialize(user, hotel)
    @user = user
    @hotel = hotel
  end

  def index?
    true
  end

  def show?
    true
  end

  def create?
    user && user.has_role?('admin')
  end

  def update?
    user && user.has_role?('admin')
  end

  def destroy?
    user && user.has_role?('admin')
  end
  
  def metrics?
    user && user.has_role?('admin')
  end
end
  