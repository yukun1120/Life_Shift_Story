Rails.application.routes.draw do
  root to: 'tops#index'
  devise_for :users
  resources :tops, only: :index
  resources :homes, only: :index
  resources :users, only: [:show, :edit, :update]
  resources :values do
    resources :reflections, only: :create
  end
  resources :habits
  resources :goods, only: :index
  resources :diaries, only: :index

end
