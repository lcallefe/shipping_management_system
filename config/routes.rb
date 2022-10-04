Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "home#index"
  devise_scope :user do  
    get '/users/sign_out' => 'devise/sessions#destroy'     
  end
  resources :orders, only: [:index]
  resources :shipping_methods, only: [:index, :new, :show, :edit, :update]
  resources :vehicles, only: [:index ]
end
