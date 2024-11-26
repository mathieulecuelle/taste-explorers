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
    end

    # Nested resources
    resources :bookings, only: [:new, :create]
    resources :questions, only: [:create]
  end


  # Dashboard routes
  get "/dashboard", to: "bookings#index"
  
  namespace :dashboard do
    resources :bookings, only: [:show]
    resources :meals, only: [:create] # Crée une route claire pour les meals
  end


  # User profile routes
  resource :user, only: [:edit, :update]
end
