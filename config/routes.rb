Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # resources :shipments, only: [:create]
  controller :shipments do
    post '/create_shipment' => :create
  end
end