Rails.application.routes.draw do
  root to: "accounting#index"

  devise_for :users

  resources :garage, only: [:index] do
    collection do
      get 'active_invoices' => 'garage#active_invoices'
      get 'passive_invoices' => 'garage#passive_invoices'
    end
  end

  resources :invoices do
    collection do
      get 'dashboard' => 'invoice_dashboard#index'
      get 'active' => 'invoice_dashboard#active_invoices'
      get 'passive' => 'invoice_dashboard#passive_invoices'
    end

    resources :payments

  end

  resources :categories do
    collection do
      get 'dashboard' => 'category_dashboard#index'
    end

    member do
      get 'dashboard' => 'category_dashboard#show'
      get 'passive_invoices' => 'category_dashboard#passive_invoices'
      get 'active_invoices' => 'category_dashboard#active_invoices'
      get 'summary' => 'category_dashboard#summary'
    end
  end

  resources :companies do
    collection do
      get 'dashboard' => 'company_dashboard#index'
    end

    member do
      get 'dashboard' => 'company_dashboard#show'
      get 'passive_invoices' => 'company_dashboard#passive_invoices'
      get 'active_invoices' => 'company_dashboard#active_invoices'
      get 'summary' => 'company_dashboard#summary'
    end
  end


  resources :vehicles do
    collection do
      get 'dashboard' => 'vehicle_dashboard#index'
    end
    member do
      get 'dashboard' => 'vehicle_dashboard#show'
      get 'passive_invoices' => 'vehicle_dashboard#passive_invoices'
      get 'active_invoices' => 'vehicle_dashboard#active_invoices'
    end
  end
end
