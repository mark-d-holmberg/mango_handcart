module MangoHandcart
  module Strategies
    class ContainmentStrategy < BaseIpStrategy
      # This strategy simply checks to see if the permitted list of IP Addresses
      # for the current handcart has an entry for the foreign IP Address

      def initialize
        @strategy = :containment
      end

      def is_in_range?(foreign_ip_address, handcart)
        handcart.ip_addresses.permitted.include?(foreign_ip_address)
      end
    end
  end
end
