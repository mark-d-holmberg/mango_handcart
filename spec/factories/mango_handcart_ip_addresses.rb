FactoryGirl.define do
  factory :mango_handcart_ip_address, class: 'MangoHandcart::IpAddress' do
    address { Faker::Internet.ip_v4_address }
    subnet_mask { "255.255.255.0" }
    handcart { |i| i.association(:company) }
    blacklisted false
  end
end
