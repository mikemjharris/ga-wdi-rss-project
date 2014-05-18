Rss::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :feeds
  resources :subscriptions
  resources :articles
  resources :relationships, only: [:create, :destroy]

  get 'feeds/update/articles', to:  'feeds#update_articles', as: 'feeds_update_articles'
  root to: 'users#show'
  
end
