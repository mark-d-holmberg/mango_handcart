MangoHandcart::Engine.routes.draw do
  resources :dns_records
  root to: 'dns_records#index'
end
