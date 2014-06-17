module MangoHandcart
  module Strategies
    # This is the parent of all IP Authorization strategies. It should only be used
    # in cases where no IP authorization is desired.
    class BaseIpStrategy
      attr_accessor :strategy

      def initialize
        @strategy = :none
      end

      def self.available_strategies
        [:containment, :inclusion, :none]
      end

      def is_in_range?(foreign_ip_address, handcart)
        raise NotImplementedError, 'Invalid IP Authorization Strategy'
      end
    end
  end
end
