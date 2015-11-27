Rails.application.routes.draw do
  resources :polls, only: [:new, :create, :show, :update, :destroy] do
    member do
      get 'fill', to: 'polls#fill'
      post 'fill', to: 'polls#submit'
    end
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
