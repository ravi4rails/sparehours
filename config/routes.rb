Rails.application.routes.draw do
  resources :skills
  root "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/register' => 'home#register'
  get '/pricing'  => 'home#pricing'

  namespace :user do
    get '/dashboard'        => 'profiles#dashboard'
    get '/edit-personal-info' => 'profiles#edit_personal_info'
    get '/edit-address-info' => 'profiles#edit_address_info'
    post '/update_profile'     => 'profiles#update_profile'
    patch 'update_personal_info' => 'profiles#update_personal_info'
    patch 'update_address_info' => 'profiles#update_address_info'
  end
end
