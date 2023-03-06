Rails.application.routes.draw do
  namespace :admin do
    get 'groups/index'
    get 'groups/show'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
  end
  namespace :admin do
    get 'posts/index'
    get 'posts/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'groups/index'
    get 'groups/show'
    get 'groups/new'
    get 'groups/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/new'
  end
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
