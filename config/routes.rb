# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    get '/auth/:provider/callback', to: 'sessions#create'

    resources :users, only: %i[new]

    resource :session, only: %i[new destroy]
  end
end
