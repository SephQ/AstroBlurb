Rails.application.routes.draw do
  resources :blurbs
  resources :blurbs     # gives all the routes needed for our blurbs, POST, GET, PATCH, DELETE, etc.
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'about', to: 'pages#about'
  get 'home', to: 'pages#home'
  get 'roast', to: 'pages#roast'
  get 'debug', to: 'pages#debug'
  get 'reading', to: 'pages#reading'
  get "blurbs", to: "blurbs#index"
  get "index", to: "blurbs#index"
end
