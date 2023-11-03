Rails.application.routes.draw do

  root "dashboard#index"
   get '/auth/shopify/credentials', to: 'shopify_auth#login'
  get '/auth/shopify/redirect', to: 'shopify_auth#callback'
  get '/redirect', to: 'shopify_auth#redirect'
end
