Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users, only:[:edit] do
    resources :programs
  end

  resources :programs
  resources :workouts, only: [:show, :new, :create]
  resources :workout_templates
  resources :exercise_templates

  root to: "home#index"

  get '/next_workout', to: 'workouts#new', as: 'next_workout'
  get '/profile', to: 'users#show', as: 'profile'
  get '/my_programs', to: 'programs#index', as: 'my_programs'
  get '/my_workout_templates', to: 'workout_templates#index', as: 'my_workout_templates'
  get '/my_exercise_templates', to: 'exercise_templates#index', as: 'my_exercise_templates'
  get '/workout_history', to: 'workouts#index', as: 'workout_history'


end
