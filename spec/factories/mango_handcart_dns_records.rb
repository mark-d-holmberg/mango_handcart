FactoryGirl.define do
  factory :mango_handcart_dns_record, class: 'MangoHandcart::DnsRecord' do
    sequence(:name) { |k| "MyString-#{k}" }
    sequence(:subdomain) { |k| "MyString-#{k}" }
    domain "MyString"
    tld_size 1
    active false
  end
end
