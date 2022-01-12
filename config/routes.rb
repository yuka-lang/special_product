Rails.application.routes.draw do
  devise_for :users
  root to: 'posts#index'

  # #タグの検索
  # get 'search' => 'posts#search'
  # 検索機能のルーティング
  get 'search_tag'=>'posts#search_tag'
  # DM機能のルーティング
  get 'chat/:id', to: 'chats#show', as: 'chat'
  resources :chats, only: [:create, :show]

  resources :users, only: [:index, :show, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
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
