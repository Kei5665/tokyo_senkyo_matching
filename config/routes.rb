# frozen_string_literal: true

Rails.application.routes.draw do
  root 'staric_pages#top'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :questions, only: %i[show] do
    post 'answer', on: :member
  end
end
