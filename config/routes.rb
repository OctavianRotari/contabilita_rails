Rails.application.routes.draw do
  devise_for :users
  root to: "accounting#index"

  resource :garage

  resources :invoices do
    collection do
      get 'dashboard' => 'invoice_dashboard#index'
      get 'active' => 'invoice_dashboard#active_invoices'
      get 'passive' => 'invoice_dashboard#passive_invoices'
    end

    resources :payments

  end

  resources :categories, only: [:new, :edit, :create, :delete, :update]

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
