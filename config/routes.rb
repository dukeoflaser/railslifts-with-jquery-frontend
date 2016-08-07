Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only:[:edit] do
    resources :programs
  end

  resources :programs

  root to: "home#index"

  get '/next_workout', to: 'workouts#new', as: 'next_workout'
  get '/profile', to: 'users#show', as: 'profile'
  get '/my_programs', to: 'programs#index', as: 'my_programs'


end
