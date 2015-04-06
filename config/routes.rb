Rails.application.routes.draw do
  get 'users/show'

  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks"}
  resources :users, only: [:show]
  resources :topics do
    resources :bookmarks do 
      resources :likes, only: [:create, :destroy]
    end
  end
  authenticated :user do
    root "topics#index", as: :authenticated_user
  end
  post :incoming, to: "incoming#create"
  root "welcome#index"
end
