Rails.application.routes.draw do
  get '/customers/:id', to: 'customers#show'
  patch '/customers/:id/items', to: 'customer_items#update'
end
