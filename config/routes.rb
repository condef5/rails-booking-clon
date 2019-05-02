Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: "home#index"

  
  namespace :admin do
    root to: "hotels#index"
    get "/metrics", to: "hotels#metrics"
    resources :hotels do
      resources :rooms
      resources :promotions
    end

    resources :rooms do
      resources :promotions, controller: 'promotions_rooms'
    end
  end

  namespace :api do
    post 'login', to: 'session#login'
    resources :hotels do
      resources :rooms do
        resources :bookings
      end
    end
  end
end
