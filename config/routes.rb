# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               confirmations: 'users/confirmations',
               passwords: 'users/passwords',
               sessions: 'users/sessions',
               unlocks: 'users/unlocks'
             }

  namespace :admin do
    resources :users, except: :destroy
  end

  root 'home#index'
end
