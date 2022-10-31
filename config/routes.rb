Rails.application.routes.draw do
  get '/customers/:id', to: 'customers#show'

  patch '/customers/:id/items', to: 'customer_items#update'

  get '/items', to: 'items#index'

  get '/supermarkets/:id', to: 'supermarkets#show'
end
