MangoHandcart::Engine.routes.draw do

  resources :ip_addresses
  resources :dns_records
  root to: 'dns_records#index'

end
