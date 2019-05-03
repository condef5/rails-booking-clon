class Api::RoomPolicy
  attr_reader :user, :room

  def initialize(user, room)
    @user = user
    @room = room
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
  