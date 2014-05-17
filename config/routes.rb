Rss::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


  resources :users
  resources :feeds
  resources :subscriptions
  resources :articles

  root to: 'users#show'
  
end
