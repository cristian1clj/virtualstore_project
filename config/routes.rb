Rails.application.routes.draw do
  resources :categories, except: :show
  delete '/products/:id', to:'products#destroy'
  post '/products/:id', to:'products#update'
  post '/products', to:'products#create'
  get '/products/new', to:'products#new', as: :new_product
  get '/products', to:'products#index'
  get '/products/:id', to:'products#details', as: :product
  get '/products/:id/edit', to:'products#edit', as: :edit_product
  
  namespace :authentication, path: '', as: '' do
    resources :users, only: [:new, :create]
    resources :sessions, only: [:new, :create]
  end
end
