Rss::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }


  resources :users do
    member do
      get :following, :followers, :favorites, :timeline
    end
  end

  resources :feeds
  resources :subscriptions
  resources :articles
  resources :relationships, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :timelines, only: [:create, :destroy]
  resources :activities

  get 'feeds/update/articles', to:  'feeds#update_articles', as: 'feeds_update_articles'
  post 'feeds/update/sortable', to:  'feeds#sortable', as: 'feeds_sortable'
  root to: 'users#show'
  
end
