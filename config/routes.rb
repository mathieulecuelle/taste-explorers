Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # devise_for :users, controllers: {
  #   registrations: 'users/registrations'
  # }

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
    resources :dishes, only: [:new, :create]
    resources :bookings, only: [:new, :create]
    get '/bookings/confirmation', to: 'bookings#confirmation', as: 'booking_confirmation'
    get '/bookings/confirmation', to: 'bookings#validate', as: 'booking_validate'
  end

  # Dashboard routes
  get "/dashboard", to: "dashboard#index"
  get 'dashboard/show', to: 'dashboard#show', as: 'dashboard_show'
  get "/dashboard/:meal_id", to: "dashboard#view_quiz", as: "view_quiz"
  post "/dashboard/:meal_id", to: "dashboard#generate_quiz", as: "generate_quiz"
end
