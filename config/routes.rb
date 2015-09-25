Rails.application.routes.draw do
  resources :polls, only: [:new, :create, :show, :update, :destroy]

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
