Rails.application.routes.draw do
  root to: "accounting#index"

  resources :invoices_dashboard, only: [:index] do
    collection do
      get 'active' => 'invoice_dashboard#active_invoices'
      get 'passive' => 'invoice_dashboard#passive_invoices'
    end
  end

  resources :company_dashboard, only: [:show] do
    member do
      get 'passive_invoices' => 'company_dashboard#passive_invoices'
      get 'active_invoices' => 'company_dashboard#active_invoices'
    end
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
