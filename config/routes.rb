Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: 'tops#index'
  devise_for :users
  resources :tops, only: :index
  resources :homes, only: :index
  resources :users, only: [:show, :edit, :update]
  resources :values do
    resources :reflections, only: [:create, :edit, :update ]
  end
  resources :habits do
    member do
      patch 'update_check'
      patch 'save_achievement'
    end
  end
  resources :goods, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :diaries, only: [:index, :create, :show, :edit, :update]
  resources :famous_quotes, only: [:index, :new, :create, :edit, :update, :destroy]
  resources :experiences
  resources :life_logs, only: :index
  resources :events
  resources :essentials
  resources :notions, only: [:index, :create, :show]
  resources :userinquiries, only: [:index, :create]
  get '/fetch_schedule', to: 'essentials#fetch_schedule'
  resources :taglines, only: [:index, :create]
end
