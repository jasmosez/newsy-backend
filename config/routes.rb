Rails.application.routes.draw do
  resources :articles, only: [:index, :show]
  resources :publications, only: [:index, :show]
  resources :ratings, only: [:show, :create, :update, :delete]
  resources :authors, only: [:index, :show, :update]
  
  post '/signup', to: 'users#create'
  post '/login', to: 'auth#login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
