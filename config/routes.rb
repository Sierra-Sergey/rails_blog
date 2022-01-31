Rails.application.routes.draw do
  resources :authors
  resources :sessions
  resources :posts do
    resources :comments do
      post 'publish', to: 'comments#publish', as: 'publish'
    end
  end
  resources :comment_votes, only: %i[create update destroy]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  # post 'posts/:id/comments/:id/publish', to: 'comments#publish', as: 'publish'

  post 'posts/:id', to: 'posts#show'
  get 'search', to: 'posts#search'
  get 'signup', to: 'authors#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'


end
