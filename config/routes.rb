Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]
  resources :companies, only: [:index,:show, :new, :create] do
    resources :invoices do
      resources :payments, only: [:new, :create]
    end
  end
end
