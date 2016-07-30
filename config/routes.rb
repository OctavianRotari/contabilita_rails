Rails.application.routes.draw do
  root to: "accounting#index"

  get 'active_invoices' => 'invoices#active_index'
  get 'passive_invoices' => 'invoices#passive_index'

  resources :company_invoices_dashboard, param: :id, only: [:show] do
    get 'passive_invoices' => 'company_invoices_dashboard#passive_invoices'
    get 'active_invoices' => 'company_invoices_dashboard#active_invoices'
  end

  resources :invoices do
    resources :payments, only: [:new, :create, :update, :edit, :destroy]
  end

  resources :companies do
    get 'summary' => 'companies#summary'
  end

  resources :vehicles do
    get 'passive_invoices' => 'vehicles#passive_invoices'
    get 'active_invoices' => 'vehicles#active_invoices'
    resources :invoices, only: [:index]
  end
end
