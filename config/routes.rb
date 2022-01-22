Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  # 検索機能のルーティング
  get 'search_tag/:tag_id' => 'posts#search_tag', as: 'search_tag'
  # DM機能のルーティング
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create, :show, :index]

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    resources :notifications, only: [:index]
  end

  resources :posts do
    get :bookmarks, on: :collection
    resource :bookmarks, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
    resources :reviews, only: [:create]
    collection do
      get 'search'
    end
  end

end
