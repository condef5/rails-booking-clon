class Admin::RoomPolicy
    attr_reader :user, :room
  
    def initialize(user, room)
      @user = user
      @room = room
    end
  
    def new?
      user && user.has_role?('admin')
    end

    def show?
        user && user.has_role?('admin')
    end
  
    def edit?
        user && user.has_role?('admin')
    end

    def create?
        user && user.has_role?('admin')
    end

    def update?
      user && user.has_role?('admin')
    end

  end
  