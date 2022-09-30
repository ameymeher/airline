Rails.application.routes.draw do
  resources :flights
  resources :users
  resources :baggages
  resources :reservations
  resources :sessions, only: [:new,:create,:destroy]

  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get 'signup', to: "users#new", as:'signup'
  get 'login', to: "sessions#new", as:'login'
  get 'logout', to: "sessions#destroy", as:'logout'
  #get 'sessions', to: "sessions#new", as:'sessions'

  #post 'sessions', to: "sessions#create", as:'create_sessions'

  # Defines the root path route ("/")
  # root "articles#index"
end
