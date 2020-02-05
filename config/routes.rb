Rails.application.routes.draw do
  resources :articles
  resources :publications
  resources :article_authors
  resources :authors
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
