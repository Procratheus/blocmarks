Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks"}
  resources :topics do
    resources :bookmarks
  end
  authenticated :user do
    root "topics#index", as: :authicated_user
  end
  post :incoming, to: "incoming#create"
  root "welcome#index"
end
