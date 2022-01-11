Rails.application.routes.draw do
  resources :posts#, :authors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'

  get 'authors', to: 'posts#authors'
  get 'author', to: 'posts#show_author'

end
