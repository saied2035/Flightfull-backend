Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

     namespace :api, defaults: { format: 'json' } do
      namespace :v1, defaults: { format: 'json' } do
        resources :reservations, only: [:index, :create, :destroy]
        resources :users, only: [:index, :create]
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
