Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # # Defines the root path route ("/")
  # # root "posts#index"

  # # User registration and profile routes
  # get "/users/sign_up", to: "users#new", as: "new_user_registration"
  # post "/users/sign_up", to: "users#create", as: "user_registration"
  # resource :user, only: [:edit, :update]

  # # Static pages
  # get "/", to: "pages#home"

  # # Meals routes
  # resources :meals do
  #   collection do
  #     get :proposals
  #   end

  #   member do
  #     get :invite
  #     get :memo
  #   end

  #   resources :bookings, only: [:new, :create]
  #   resources :questions, only: [:create]
  # end

  # # Bookings routes
  # resources :bookings, only: [:index]

  # # Dashboard routes
  # get "/dashboard", to: "bookings#index", as: "dashboard"
  # post "/dashboard", to: "meals#create", as: "dashboard_create_meal"
  # get "/dashboard/bookings/:id", to: "bookings#show", as: "dashboard_booking"
end
