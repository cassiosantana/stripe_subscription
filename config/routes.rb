Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  get 'home/index'
  resources :users
  resources :subscriptions, only: :new do
    scope module: "subscriptions" do
      collection do
        resource :unsubscribe, only: :destroy
        resource :resubscribe, only: :new
        resource :upgrade, only: :update
        resource :downgrade, only: :update
      end
    end
  end

  mount StripeEvent::Engine, at: '/stripe/webhook'
end
