Rails.application.routes.draw do
  resources :checkout_baskets, only: [:index] do
    collection do
      get "calculations", to: "checkout_baskets#calculations"
      get "orders", to: "checkout_baskets#orders"
    end
  end
  root 'checkout_baskets#index'
end
