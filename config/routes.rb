Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resource :session, only: %i[new create destroy]
  resources :questions, except: %i[index show new]
  resources :tags, only: :show
end
