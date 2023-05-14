Rails.application.routes.draw do
  root to: 'tops#index'
  devise_for :users
  resources :tops, only: :index
  resources :homes, only: :index
  resources :users, only: [:show, :edit, :update]
  resources :values do
    resources :reflections, only: :create
  end
  resources :habits do
    collection do
      patch 'update_checkbox_state'
      patch 'update_achievement_rate'
    end
  end
  resources :goods, only: :index
  resources :diaries, only: :index

end
