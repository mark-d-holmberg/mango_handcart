module MangoHandcart
  class DnsRecord < ActiveRecord::Base
    validates :name, presence: true
  end
end
