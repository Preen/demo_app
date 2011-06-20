Lensfinder::Application.routes.draw do

  # replace devise_for :users with:
  devise_for :users,  :controllers => { :registrations => "users/registrations" }
  
  resources :comments

  root :to => "finder#index"

  resources :categories, :prices, :profiles, :finder, :users

  resources :services, :only => [:index, :create]

  resources :retailers, :path => "linsbutiker", do
    member do
      post :vote_up
      post :vote_down
    end
  end

  resources :products, :path => "linser"

  match 'shipping_info' => 'finder#shipping_info'

  match "tagged", :controller => "retailers", :action => "tagged"

  match "tagged", :controller => "products", :action => "tagged"

  match "/prices/:id/new/" => "prices#new"

  match "/finder/productSizes/:id" => "finder#sizes"

  match "/finder/search/" => "finder#search"

  match "/finder/products/:id" => 'finder#products'

  match "/finder/search/:prod_id/:si_id/:amount/" => "finder#search"

  match "/products/search/:id/" => "products#search"

  match "/retailers/search/" => "retailers#search"

  match "/products/update_products/" => "products#update_products"

  match '/auth/:service/callback' => 'services#create'

end
