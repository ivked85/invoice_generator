Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  
  authenticate :user do
    resources :invoices
    resources :invoice_templates
  end
end
