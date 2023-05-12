Rails.application.routes.draw do
  root to: 'tops#index'
  devise_for :users
  resources :tops, only: :index
  resources :homes, only: :index
  resources :users, only: [:show, :edit, :update]

end
