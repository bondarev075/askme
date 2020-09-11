Rails.application.routes.draw do
  root "users#index"
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  resources :questions, except: [:index, :show, :new]
  resources :tags, only: :show

  get 'users' => 'users#show'
  get 'sign_up' => 'users#new'
  get 'log_in' => 'sessions#new'
  get 'log_out' => 'sessions#destroy'
end
