module MangoHandcart
  class DnsRecord < ActiveRecord::Base
    has_one :handcart, class_name: MangoHandcart.handcart_class.to_s

    validates :name, presence: true

    # Make sure we don't assign reserved subdomains
    validates :subdomain,
      presence: true,
      exclusion: { in: MangoHandcart.reserved_subdomains }

    # Make sure they're unique unless we enable A-Record lookups
    validates :subdomain, uniqueness: { case_sensitive: false, scope: [:domain] }, unless: lambda { MangoHandcart.enable_a_record_lookups }

    scope :allocated, -> { DnsRecord.includes(:handcart).where("#{MangoHandcart.handcart_class.model_name.plural}.dns_record_id IS NOT NULL").references(:handcart) }
    scope :unallocated, -> { DnsRecord.includes(:handcart).where("#{MangoHandcart.handcart_class.model_name.plural}.dns_record_id IS NULL").references(:handcart) }
    scope :unallocated_or_current, lambda { |handcart| DnsRecord.includes(:handcart).where("#{MangoHandcart.handcart_class.model_name.plural}.dns_record_id IS NULL OR #{MangoHandcart.handcart_class.model_name.plural}.dns_record_id IN (?)", handcart.try(:dns_record_id)).references(:handcart) }
    scope :ordered, -> { order("mango_handcart_dns_records.subdomain ASC") }

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
      if my_dns_record && request.subdomain.present? && !MangoHandcart.reserved_subdomains.include?(request.subdomain) && my_dns_record.handcart
        if my_dns_record.handcart.respond_to?(:active?)
          my_dns_record.handcart.active?
        else
          # Just default to true since we found the record
          true
        end
      end
    end


    private

    def normalize_subdomain
      self.subdomain = subdomain.squish.gsub(/\s+|\+|\/|=|\?/, '').parameterize
    end

  end
end
