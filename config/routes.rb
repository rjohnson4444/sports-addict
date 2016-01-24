Rails.application.routes.draw do
  get 'users/edit'

  root 'home#index'
  get 'dashboard',               to: 'home#show'
  get '/auth/twitter',           as: :login
  get '/logout',                 to: 'sessions#destroy'
  get '/auth/twitter/callback',  to: 'sessions#create'

  resources :users, only: [:edit, :update]
  resources :home, only: [:update]
  resources :teams, only: [:index, :show]
  resources :posts, only: [:create, :destroy]
  resources :follows, only: [:create, :destroy]
end
