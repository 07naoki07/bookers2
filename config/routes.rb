Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
   resources :users, only: [:show, :edit, :update, :index]
   resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy]
  end
  get "/home/about" => "homes#about", as: "about"
  resources :users do
   resource :relationships, only: [:create, :destroy]
   get 'followings' => 'relationships#followings', as: 'followings'
   get 'followers' => 'relationships#followers', as: 'followers'
  end
  get "search" => "searches#search"
   # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
