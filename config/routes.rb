Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  get 'home/index'
  resources :users
  resources :subscriptions, only: :new

  mount StripeEvent::Engine, at: '/stripe/webhook'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
