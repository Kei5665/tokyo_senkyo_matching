# frozen_string_literal: true

Rails.application.routes.draw do
  root 'staric_pages#top'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  resources :questions, only: %i[show] do
    post 'answer', on: :member
  end
  resources :users
end
