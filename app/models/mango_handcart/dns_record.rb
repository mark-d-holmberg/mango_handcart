module MangoHandcart
  class DnsRecord < ActiveRecord::Base

    validates :name, presence: true

    # Make sure we don't assign reserved subdomains
    validates :subdomain,
      presence: true,
      exclusion: { in: MangoHandcart.reserved_subdomains }

    # Make sure they're unique unless we enable A-Record lookups
    validates :subdomain, uniqueness: { case_sensitive: false, scope: [:domain] }, unless: lambda { MangoHandcart.enable_a_record_lookups }

    before_save :normalize_subdomain

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

    def self.matches?(request)
      my_dns_record = DnsRecord.lookup(request)
      if my_dns_record && request.subdomain.present? && !MangoHandcart.reserved_subdomains.include?(request.subdomain) #&& my_dns_record.handcart
        true
        # if my_dns_record.handcart.respond_to?(:active?)
        #   my_dns_record.handcart.active?
        # else
        #   # Just default to true since we found the record
        #   true
        # end
      end
    end


    private

    def normalize_subdomain
      self.subdomain = subdomain.squish.gsub(/\s+|\+|\/|=|\?/, '').parameterize
    end

  end
end
