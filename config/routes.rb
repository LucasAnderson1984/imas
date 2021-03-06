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

  resources :bill_of_materials, except: :destroy
  resources :customers, except: :destroy
  resources :items, except: :destroy do
    resources :item_unit_of_measures,
              controller: 'items/item_unit_of_measures',
              only: %i[create edit new update]
  end
  resources :sales, except: :destroy
  resources :unit_of_measures, except: :destroy

  root 'home#index'
end
