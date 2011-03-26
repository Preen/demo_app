Lensfinder::Application.routes.draw do

  resources :profiles

  root :to => "finder#index"

  resources :categories
  resources :prices
  resources :retailers
  resources :products
  resources :finder

  match "/finder/products/:id" => "finder#products"

  match "/finder/sizes/:id" => "finder#sizes"

  match "/finder/search/:prod_id/:si_id" => "finder#search"

end
