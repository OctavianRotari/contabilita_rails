Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]

  resources :companies do
    resources :invoices do
      resources :payments, only: [:new, :create, :update, :edit, :destroy]
    end
  end

  resources :vehicles do
    resources :invoices, only: [:index]
  end
end
