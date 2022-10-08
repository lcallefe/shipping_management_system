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
  resources :first_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :first_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :first_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :second_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :second_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :second_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
  resources :third_price_distances, only:[:index, :new, :edit, :update, :create]
  resources :third_price_weights, only:[:index, :new, :edit, :update, :create]
  resources :third_delivery_time_distances, only:[:index, :new, :edit, :update, :create]
end
