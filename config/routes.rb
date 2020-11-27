Rails.application.routes.draw do
  resources :posts
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
