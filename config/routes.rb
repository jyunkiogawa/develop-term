Rails.application.routes.draw do
  get 'comments/create'
  get 'topics/new'
  get 'sessions/new'

  root 'pages#index'
  get 'pages/help'

  resources :users
  resources :topics
  
  get   'favorites/index'
  post  'favorites', to: 'favorites#create'
  delete 'favorites', to: 'favorites#destroy'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  resources :topics do 
  resources :comments, only: [:create, :destroy]
  end 
end