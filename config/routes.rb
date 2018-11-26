Rails.application.routes.draw do

  root :to => 'reservations#home'

  devise_for :users, controllers: {registrations: 'registrations'}

  resources :parkings
  resources :reservations
  resources :room_types
  resources :users
  resources :users_roles
  resources :statistics, only: %i(new)
  get 'statistics' , :to => 'statistics#new'
  get 'admin_reservations' , :to => 'reservations#index_admin'
  post 'statistics', :to => 'statistics#perform'

  get 'home' => "reservations#home"

end
