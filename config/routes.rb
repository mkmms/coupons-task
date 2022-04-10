# frozen_string_literal: true

Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :products
  resources :carts do
    collection do
      post :confirm_order
    end
  end
  resources :coupons do
    member do 
      post :update_status
    end
    collection do
      post :apply
    end
  end
  
end
