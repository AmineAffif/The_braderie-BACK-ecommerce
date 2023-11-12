Rails.application.routes.draw do
  resources :products, only: [:index, :show]
  resources :orders, only: [:create]
end