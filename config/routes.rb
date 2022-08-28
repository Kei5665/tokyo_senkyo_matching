# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#top'

  get '/guest_login', to: 'user_sessions#guest_login'
  get '/result', to: 'static_pages#result'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'
  
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :questions, only: %i[show] do
    post 'answer', on: :member
  end
end
