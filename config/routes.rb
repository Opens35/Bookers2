Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root to: "homes#top"
  get "home/about" => "homes#about"
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorites, only:[:create, :destroy ]
    resources :book_comments, only:[:create, :destroy]
  end
  resources :users, only: [:new, :index,:show, :edit, :update, :create] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end
  
end
