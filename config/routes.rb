Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

     namespace :api, defaults: { format: 'json' } do
      namespace :v1, defaults: { format: 'json' } do
        post 'login', to: 'auth#login'
        get 'auth', to: 'auth#persist'
        resources :reservations, only: [:index, :create, :destroy]
        resources :users
        resources :items, only: [:index, :create, :update, :destroy]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
