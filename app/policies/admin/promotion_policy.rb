class Admin::PromotionPolicy
    attr_reader :user, :promotion
  
    def initialize(user, promotion)
      @user = user
      @promotion = promotion
    end
  
    def index?
        user && user.has_role?('admin')
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
  