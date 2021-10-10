Rails.application.routes.draw do
  devise_for :property_owners
  devise_for :users
  root to: 'home#index'
  get 'my_profile', to: 'users#my_profile'

  resources :properties, only: [:index, :show, :new, :create] do
    get 'my_properties', on: :collection 
    #my_properties é uma rota customizada
    resources :property_reservations, only: %i[create show], shallow: true do
    #%i[create show] é equivalente a [:create, :show]
    #outro exemplo: %w[rui roi rau] == ['rui','roi','rau']
    post 'accept', on: :member
    end
  end    
  
  resources :property_types, only:[:show]
  #only (opcional): evita criar todas as rotas do metodo resources
  
  
end
