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
    get '/profile'          => 'profiles#edit_profile'
    post '/update_profile'  => 'profiles#update_profile'
  end
end
