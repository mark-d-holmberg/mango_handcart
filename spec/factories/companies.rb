FactoryGirl.define do
  factory :company do
    sequence(:name) { |n| "MyString-#{n}" }
    dns_record { |i| i.association(:mango_handcart_dns_record) }
    active { true }
  end
end
