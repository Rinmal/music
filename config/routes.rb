Rails.application.routes.draw do
  namespace :public do
    get 'searches/search'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  namespace :admin do
    root to: 'homes#top'

    resources :posts, only: [:index, :show] do
      resources :comments, only: [:destroy]
    end

    get 'posts/tag/:body' => 'posts#tag', as: :tag

    resources :users, only: [:index, :show, :update] do
      patch 'is_freezed' => 'users#is_freezed'
      get :followings, on: :member
      get :followers, on: :member
    end

    resources :groups, only: [:index, :show] do
      get 'chat' => 'groups#chat', on: :member
    end

    get 'search' => 'searches#search'
    resources :messages, only: [:destroy]

  end

  scope module: :public do
    root to: 'homes#top'

    resources :posts, except: [:edit, :update] do
      resource :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    get 'posts/tag/:body' => 'posts#tag', as: :tag

    resources :users, only: [:show, :edit, :update] do
      get 'unsubscribe' => 'users#unsubscribe'
      patch 'is_deleted' => 'users#is_deleted'
      get 'favorites' => 'favorites#index'
      resource :relationships, only: [:create, :destroy]
      get :followings, on: :member
      get :followers, on: :member
    end

    resources :groups do
      get "join" => "groups#join"
      get 'chat' => 'groups#chat', on: :member
    end

    get 'search' => 'searches#search'
    resources :messages, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
