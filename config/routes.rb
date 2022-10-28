Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end 
  resources :shipping_methods, only:[:index, :new, :create, :edit, :update, :show]
 
  resources :price_distances, only:[:index, :new, :edit, :update, :create]
  resources :price_weights, only:[:index, :new, :edit, :update, :create]
  resources :delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :work_orders, only:[:index, :new, :create, :show, :edit, :update, :show] do 
    get 'search', on: :collection
    get 'pending', on: :collection
  end
  resources :vehicles, only:[:index, :show, :new, :create, :edit, :update] do 
    get 'search', on: :collection
  end
end
