# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    get '/auth/:provider/callback', to: 'sessions#create'
    resource :session, only: %i[new destroy]

    resources :users, only: %i[new]
    resource :profile, only: %i[show edit update]

    resources :bulletins, only: %i[show new create]
  end
end
