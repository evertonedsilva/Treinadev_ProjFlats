Rails.application.routes.draw do
  devise_for :property_owners
  devise_for :users
  root to: 'home#index'

  resources :properties, only: [:index, :show, :new, :create] do
    get 'my_properties', on: :collection 
    #my_properties é uma rota customizada
    resources :property_reservations, only: %i[create show], shallow: true
    #%i[create show] é equivalente a [:create, :show]
    #outro exemplo: %w[rui roi rau] == ['rui','roi','rau']
  end    
  
  resources :property_types, only:[:show]
  #only (opcional): evita criar todas as rotas do metodo resources
  
  
end
