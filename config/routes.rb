Rails.application.routes.draw do
  devise_for :users, :controllers => { omniauth_callbacks: "omniauth_callbacks"}
  get 'welcome/about'
  root "welcome#index"
end
