Rails.application.routes.draw do
  devise_for :users
  root 'homes#index'
  resources :posts, except: %i[new edit] do
    resources :comments, only: %i[create destroy]
  end
end
