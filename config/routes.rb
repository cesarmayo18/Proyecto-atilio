Rails.application.routes.draw do
  resources :orders
  root to: 'home#index'
  resources :products
  resources :profiles
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  get 'order/new/:id', to: 'orders#buy'
  get "order/:id/confirmation/", to: 'orders#confirmation'
  get "repartidor/dashboard/", to: 'orders#dashboard'
  get "order/entregar/:id", to: 'orders#entregar'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
