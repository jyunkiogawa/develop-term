Rails.application.routes.draw do
  get 'comments/create'
  get 'topics/new'
  get 'sessions/new'

  root 'pages#index'
  get 'pages/help'

  get   'users/index'
  get   'users/show'
  get   'users/all'
  put   'users/edit'
  get   'users/edit'

  resources :users
  resources :topics
  
  get   'favorites/index'
  post  'favorites', to: 'favorites#create'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  resources :topics do 
    resources :comments, only: [:create, :destroy]
  end
   
  resources :users do
    member do
      get :following, :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  
end