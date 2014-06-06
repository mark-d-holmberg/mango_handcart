Rails.application.routes.draw do

  mount MangoHandcart::Engine => "/mango_handcart"

  # The default domain constraint configures what should match
  # when all the other routes fail to match other namespaces
  constraints MangoHandcart::DomainConstraint.default_constraint do
    root to: 'public#index'
  end

end
