Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index]
  resources :companies, only: [:index,:show, :new, :create] do
    resources :invoices, only: [:new, :create, :show]
  end
end
