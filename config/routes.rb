Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "users/omniauth_callbacks"}
  resources :topics do
    resources :bookmarks
  end
  post :incoming, to: "incoming#create"
  root "welcome#index"
end
