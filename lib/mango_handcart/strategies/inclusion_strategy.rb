module MangoHandcart
  module Strategies
    class InclusionStrategy < BaseIpStrategy
      # This strategy checks the permitted list of IP Addresses for the current handcart
      # to insure not only that the list contains the foreign IP address, but that it is
      # also within the same subnet group.

      def initialize
        @strategy = :inclusion
      end

      def is_in_range?(foreign_ip_address, handcart)
        handcart.ip_addresses.permitted.any? { |handcart_ip_address| IPAddr.new("#{handcart_ip_address.address}/#{handcart_ip_address.subnet_mask}").include?(foreign_ip_address) }
      end
    end
  end
end
