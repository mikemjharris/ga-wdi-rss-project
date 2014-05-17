Rss::Application.routes.draw do
  devise_for :users

  resources :users
  resources :feeds
  resources :subscriptions
  resources :articles

  root to: 'users#show'
  
end
