Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

     namespace :api, defaults: { format: 'json' } do
      namespace :v1, defaults: { format: 'json' } do
        post 'login', to: 'auth#login'
        get 'auth', to: 'auth#persist'
        resources :users do
        resources :reservations, only: [:index, :create, :destroy]
        end
        resources :items, only: [:index, :new, :create, :update, :destroy]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
