Rails.application.routes.draw do
  get 'chats/show'
  get 'posts/index'
  get 'posts/show'
  devise_for :users
  root to: 'homes#top'

  # DM機能のルーティング
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create, :show]

  resources :users, only: [:index, :show, :edit, :update]

  resources :posts do
    resource :bookmarks, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

end
