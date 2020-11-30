Rails.application.routes.draw do
  get "/posts/my_feed", to: "posts#index", my_feed: true, as: "my_feed"

  resources :posts
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  devise_for :users
  devise_scope :user do
    authenticated :user do
      root to: "posts#index", as: :authenticated_root
    end
    unauthenticated :user do
      root to: "devise/registrations#new", as: :unauthenticated_root
    end
  end
end
