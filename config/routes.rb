Rails.application.routes.draw do
  root 'home#index', as: :login
  get 'dashboard', to: 'home#show'
  resources :teams, only: [:index, :show]
end
