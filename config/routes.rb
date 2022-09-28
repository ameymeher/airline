Rails.application.routes.draw do
  resources :flights
  resources :users
  resources :baggages
  resources :reservations

  root "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end