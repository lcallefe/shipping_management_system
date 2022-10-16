Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end 
  # Modalidades de entrega / configuração Preços | Prazos | Pesos
  resources :sedexes, only:[:index, :new, :create, :edit, :update]
  resources :sedex_dezs, only:[:index, :new, :create, :edit, :update]
  resources :expressas, only:[:index, :new, :create, :edit, :update]
  resources :sedex_dez_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :sedex_dez_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :sedex_dez_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :sedex_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :sedex_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :sedex_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :expressa_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :expressa_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :expressa_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :work_orders, only:[:index, :new, :create, :show, :edit, :update, :show] do 
    get 'search', on: :collection
    get 'pending', on: :collection
    put 'complete', on: :member, to: "work_orders#complete", param: :work_order
    patch 'complete', on: :member, to: "work_orders#complete", param: :work_order
    get 'complete', on: :member, to: "work_orders#complete"
  end
  resources :vehicles, only:[:index, :show, :new, :create, :edit, :update] do 
    get 'search', on: :collection
  end

  # resources :complete, only:[:edit, :update]

end
