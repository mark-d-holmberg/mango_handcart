module MangoHandcart
  class DnsRecord < ActiveRecord::Base
    validates :name, presence: true

    validates :subdomain, uniqueness: { case_sensitive: false, scope: [:domain] }, unless: lambda { MangoHandcart.enable_a_record_lookups }

    # Lookup a DNS record by the subdomain/domain
    def self.lookup(request)
      if MangoHandcart.enable_a_record_lookups
        # Find it by the domain AND subdomain
        find_by(domain: request.domain, subdomain: request.subdomain)
      else
        # Just find it by the subdomain
        find_by(subdomain: request.subdomain)
      end
    end

  end
end
