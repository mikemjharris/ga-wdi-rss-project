Rss::Application.routes.draw do
  devise_for :users

  resources :users
  resources :feeds

  root to: 'users#index'
  
end
