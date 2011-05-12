Lensfinder::Application.routes.draw do

  resources :comments

  resources :authentications

  root :to => "finder#index"

  resources :categories, :prices, :profiles, :finder, :products, :users, :user_sessions, :authentications

  resources :retailers do
    member do
      post :vote_up
      post :vote_down
    end
  end

  match 'shipping_info' => 'finder#shipping_info'

  match '/auth/:provider/callback' => 'authentications#create'

  match "tagged", :controller => "retailers", :action => "tagged"

  match 'login' => 'user_sessions#new', :as => :login

  match 'logout' => 'user_sessions#destroy', :as => :logout

  match "/prices/:id/new/" => "prices#new"

  match "/finder/productSizes/:id" => "finder#sizes"

  match "/finder/search/" => "finder#search"

  match "/finder/products/:id" => 'finder#products'

  match "/finder/search/:prod_id/:si_id/:amount/" => "finder#search"

  match "/products/search/:id/" => "products#search"

  match "/retailers/search/" => "retailers#search"

  match "/products/update_products/" => "products#update_products"

end
