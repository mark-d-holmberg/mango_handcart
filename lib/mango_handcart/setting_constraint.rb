module MangoHandcart
  class SettingConstraint

    attr_accessor :matcher, :feature

    def initialize(matcher, feature)
      @matcher = matcher
      @feature = feature
    end

    def matches?(request)
      my_dns_record = DnsRecord.lookup(request)
      if my_dns_record && request.subdomain.present? && my_dns_record.handcart
        if my_dns_record.handcart.respond_to?(@matcher)
          my_dns_record.handcart.send(@matcher.to_s, @feature)
        else
          # The handcart doesn't respond to the matcher, so no point checking
          false
        end
      end
    end

  end
end
