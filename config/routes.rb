Rails.application.routes.draw do
  root to: "accounting#index"

  resources :invoice, only: [:index]
end
