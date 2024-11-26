# Rails.application.routes.draw do
#   devise_for :users
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Defines the root path route ("/")
#   # root "posts#index"

#   # Root path
#   root to: "pages#home"

#   # User registration and profile routes
#   get "/users/sign_up", to: "users#new", as: "new_user_registration"
#   post "/users/sign_up", to: "users#create", as: "user_registration"
#   resource :user, only: [:edit, :update]

#   # Static pages
#   get "/", to: "pages#home"

#   # Meals routes
#   resources :meals do
#     collection do
#       get :proposals
#     end

#     member do
#       get :invite
#       get :memo
#     end

#     resources :bookings, only: [:new, :create]
#     resources :questions, only: [:create]
#   end

#   # Bookings routes
#   resources :bookings, only: [:index]

#   # Dashboard routes
#   get "/dashboard", to: "bookings#index", as: "dashboard"
#   post "/dashboard", to: "meals#create", as: "dashboard_create_meal"
#   get "/dashboard/bookings/:id", to: "bookings#show", as: "dashboard_booking"
# end

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

  # Bookings routes
  resources :bookings, only: [:index, :show] # Inclure `:show` ici pour simplifier

  # Dashboard routes
  namespace :dashboard do
    resources :bookings, only: [:show]
    resources :meals, only: [:create] # Crée une route claire pour les meals
  end

  # User profile routes
  resource :user, only: [:edit, :update]
end
