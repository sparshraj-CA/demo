Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/items/search", to: "items#search"

  resources :items
  resources :customers
  #resources :orders

  # resources :customers do 
  #   resources :orders do
  #     resources :items do
  #     end
  #   end
  # end

  get "/orders/:cid", to: "orders#index"
  get "/orders/buy/:cid/:itemid", to: "orders#buy"
  get "/orders/placeorder/:cid/:itemid", to: "orders#placeorder"
 
end
