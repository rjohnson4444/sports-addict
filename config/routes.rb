Rails.application.routes.draw do
  root 'home#index'
  get 'dashboard',      to: 'home#show'
  get '/auth/twitter',  as: :login
  
  resources :teams, only: [:index, :show]
end
