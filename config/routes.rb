Rails.application.routes.draw do
  resources :products, only: [:index, :show] do
    resources :reviews, only: [:create]
  end
  resources :orders, only: [:create]
end
