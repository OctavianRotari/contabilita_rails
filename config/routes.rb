Rails.application.routes.draw do
  root to: "accounting#index"

  get 'active_invoices' => 'invoices#active_index'
  get 'passive_invoices' => 'invoices#passive_index'

  resources :companies do
    resources :invoices do
      resources :payments, only: [:new, :create, :update, :edit, :destroy]
    end
  end

  resources :vehicles do
    resources :invoices, only: [:index]
  end
end
