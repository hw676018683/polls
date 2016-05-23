Rails.application.routes.draw do
  match "/websocket", :to => ActionCable.server, via: [:get, :post]

  get '/v/:key' => "short_urls#show", as: :short

  resources :polls, except: [:edit] do
    member do
      get :fill
      post 'fill', to: 'polls#submit'
      get :report
    end

    resources :votes, only: [:create, :show]
  end

  resources :votes, only: [:index]

  get '/auth/:provider/callback', to: 'sessions#create'

  root 'home#index'

  delete '/signout', to: 'sessions#destroy', as: :signout
end
