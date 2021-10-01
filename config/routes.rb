Rails.application.routes.draw do
  root to: 'home#index'
  resources :properties, only:[:show, :new, :create]  
  resources :property_types, only:[:show]
  #only (opcional): evita criar todas as rotas do metodo resources
end
