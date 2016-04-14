Rails.application.routes.draw do
  root to: "accounting#index"
  resources :invoices, only: [:index,:show]
end
