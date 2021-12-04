Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  root 'homes#index'
  resources :users, only: %i[show]
  resources :posts, except: %i[new edit] do
    resources :comments, only: %i[create destroy]
    resource :likes, only: %i[create destroy]
    resource :marks, only: %i[create destroy]
  end
end
