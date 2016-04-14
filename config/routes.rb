Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]
  resources :clients_and_suppliers, only: [:show] do
    resources :invoices, only: [:index]
  end
end
