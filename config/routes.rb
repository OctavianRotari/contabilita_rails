Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]
  resources :clients_and_suppliers, only: [:show] do
    get 'invoices' => 'invoices#clients_and_supliers_invoices'
  end
end
