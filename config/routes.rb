Rails.application.routes.draw do
  match "/websocket", :to => ActionCable.server, via: [:get, :post]

  resources :polls, only: [:new, :create, :show, :update, :destroy] do
    member do
      get 'fill', to: 'polls#fill'
      post 'fill', to: 'polls#submit'
      get :report
    end

    resources :votes, only: [:create, :show]
  end

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'
end
