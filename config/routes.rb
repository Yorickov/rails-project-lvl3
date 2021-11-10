# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'home#index'

    get '/auth/:provider/callback', to: 'sessions#github'
    resource :session, only: %i[new create destroy]

    resources :users, only: %i[new]
    resource :profile, only: %i[show edit update]

    resources :bulletins, only: %i[show new create edit update] do
      member do
        patch :moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'home#index'
      resources :categories, only: %i[index new create edit update destroy]
      resources :bulletins, only: %i[index] do
        member do
          patch :approve
          patch :reject
          patch :archive
        end
      end
    end
  end
end
