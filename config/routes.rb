Rails.application.routes.draw do
  get "/posts/my_feed", to: "posts#index", my_feed: true, as: "my_feed"
  get "/friends", to: "friendships#index", as: "friends"

  resources :posts
  resources :friend_requests, only: [:index, :create, :destroy]
  resources :friendships, only: [:index, :create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :comments, only: [:create, :destroy]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    authenticated :user do
      root to: "posts#index", as: :authenticated_root
    end
    unauthenticated :user do
      root to: "devise/registrations#new", as: :unauthenticated_root
    end
  end

  resources :users, only: [:index, :show, :update]
end
