Rss::Application.routes.draw do
  devise_for :users

  resources :users
  resources :feeds
  resources :subscriptions

  root to: 'users#index'
  
end
