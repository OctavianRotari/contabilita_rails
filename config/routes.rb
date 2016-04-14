Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]
  resources :companies, only: [:show] do
    get 'invoices' => 'invoices#company_invoices'
  end
end
