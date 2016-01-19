Rails.application.routes.draw do
  root 'home#index'
  get 'dashboard',               to: 'home#show'
  get '/auth/twitter',           as: :login
  get '/logout',                 to: 'sessions#destroy'
  get '/auth/twitter/callback',  to: 'sessions#create'

  resources :teams, only: [:index, :show]
  resources :posts, only: [:create, :destroy]
end
