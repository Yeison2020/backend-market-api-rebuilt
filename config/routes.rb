Rails.application.routes.draw do
  # resources :category_items
  # resources :categories
  resources :items, only: [:index, :show, :create, :update, :destroy]
  resources :users, only: [:create, :destroy]

  # Customs routes 

  #Update item == sold: true
  patch 'items/:id/sold', to:'items#sold'

  # Gets all the purchased_items from a user 
  get 'users/:id/purchased_items', to:'items#purchased_items'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
