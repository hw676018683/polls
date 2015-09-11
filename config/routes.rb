Rails.application.routes.draw do
  resources :polls, only: [:new, :create, :show, :destroy]

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
