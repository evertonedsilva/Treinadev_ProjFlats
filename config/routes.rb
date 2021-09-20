Rails.application.routes.draw do
  root to: 'home#index'
  get '/properties/:id', to: 'home#show'
  resources :properties
end
