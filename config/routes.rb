Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Health check route
  get "up", to: "rails/health#show", as: :rails_health_check

  # Root path
  root to: "pages#home"

  # Meals routes
  resources :meals do
    collection do
      get :proposals
    end

    member do
      get :invite
      get :memo
      post :duplicate
    end

    # Nested resources
    resources :bookings, only: [:new, :create]
    resources :questions, only: [:create]
  end


  # Dashboard routes
  get "/dashboard", to: "dashboard#show"

  
end
