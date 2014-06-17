require 'singleton'

module MangoHandcart
  class IpAuthorization
    # A singleton
    attr_accessor :ip_authorization_strategy, :strategy

    include Singleton

    def initialize
      @ip_authorization_strategy = MangoHandcart.ip_authorization_strategy

      # Setup what strategy we're using
      case @ip_authorization_strategy
      when :none
        nil
      when :containment
        @strategy = MangoHandcart::Strategies::ContainmentStrategy.new
      when :inclusion
        @strategy = MangoHandcart::Strategies::InclusionStrategy.new
      else
        nil
      end
    end

  end
end
