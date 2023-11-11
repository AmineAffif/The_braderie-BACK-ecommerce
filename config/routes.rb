Rails.application.routes.draw do
  get 'orders/create'
  get 'products/index'
  get 'products/show'
  # Defines the root path route ("/")
  # root "articles#index"

  # Routes pour les produits
  resources :products, only: [:index, :show]

  # Route pour créer une commande
  post '/orders', to: 'orders#create'
  
end
