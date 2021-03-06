Rails.application.routes.draw do

  authenticated :user do
    root 'invoice_dashboard#index', as: :authenticated_root
  end

  root to: "accounting#index"

  devise_for :users

  resources :general_expenses, only: [:index] do
    collection do
      get 'active_invoices' => 'general_expenses#active_invoices'
      get 'passive_invoices' => 'general_expenses#passive_invoices'
    end
  end

  resources :fuel_receipts

  resources :invoices, only: [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'dashboard' => 'invoice_dashboard#index'
      get 'active' => 'invoice_dashboard#active_invoices'
      get 'passive' => 'invoice_dashboard#passive_invoices'
    end

    resources :payments, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :insurances do
    resources :receipts, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :tickets do
    collection do
      get 'administrative_dashboard' => 'tickets_dashboard#administrative'
      get 'vehicle_dashboard' => 'tickets_dashboard#vehicle'
    end
  end

  resources :categories, only: [:new, :create, :edit, :update, :destroy] do
    collection do
      get 'dashboard' => 'category_dashboard#index'
    end
    member do
      get 'insurances' => 'insurance_dashboard#category_insurances'
      get 'dashboard' => 'category_dashboard#show'
      get 'passive_invoices' => 'category_dashboard#passive_invoices'
      get 'active_invoices' => 'category_dashboard#active_invoices'
    end
  end

  resources :companies do
    collection do
      get 'dashboard' => 'company_dashboard#index'
    end
    member do
      get 'dashboard' => 'company_dashboard#show'
      get 'insurances' => 'insurance_dashboard#company_insurances'
      get 'fuel_receipts' => 'fuel_receipt_dashboard#company_receipts'
      get 'passive_invoices' => 'company_dashboard#passive_invoices'
      get 'active_invoices' => 'company_dashboard#active_invoices'
    end
  end

  resources :vehicles, only: [:show, :new, :create, :edit, :update, :destroy] do
    collection do
      get 'dashboard' => 'vehicle_dashboard#index'
    end
    member do
      get 'dashboard' => 'vehicle_dashboard#show'
      get 'fuel_receipts' => 'fuel_receipt_dashboard#vehicle_receipts'
      get 'passive_invoices' => 'vehicle_dashboard#passive_invoices'
      get 'active_invoices' => 'vehicle_dashboard#active_invoices'
    end
  end
end
