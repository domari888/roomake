Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  resources :users, only: %i[show]
  resources :posts, except: %i[new edit] do
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
  end
end
