require "mango_handcart/engine"
require "mango_handcart/domain_constraint"
require "mango_handcart/setting_constraint"
require "mango_handcart/acts_as_handcart"
require "mango_handcart/ip_authorization"
require "mango_handcart/simple_form"
require 'haml'
require 'jquery-rails'
require 'bootstrap-sass'
require 'kaminari'

module MangoHandcart
  module Strategies
    # Load the IP Authorization strategies
    autoload :BaseIpStrategy, "mango_handcart/strategies/base_ip_strategy"
    autoload :InclusionStrategy, 'mango_handcart/strategies/inclusion_strategy'
    autoload :ContainmentStrategy, 'mango_handcart/strategies/containment_strategy'
  end

  # The domain constraints for route matching
  mattr_accessor :domain_constraints
  @@domain_constraints = []

  # Do we match on the subdomain AND domain? (A-Records)
  mattr_accessor :enable_a_record_lookups
  @@enable_a_record_lookups = false

  # The subdomains which cannot be assigned to a DNS record
  mattr_accessor :reserved_subdomains
  @@reserved_subdomains = []

  # Which class will invoke a call to `acts_as_handcart`
  mattr_accessor :handcart_class
  @@handcart_class = nil

  # What view_path can I use to view the handcart?
  mattr_accessor :handcart_show_path
  @@handcart_show_path = nil

  # What class is used for the Subdomain/Domain matching?
  mattr_accessor :dns_record_class
  @@dns_record_class = "MangoHandcart::DnsRecord"

  # What strategy are they using for IP Forwarding/Blocking
  mattr_accessor :ip_authorization_strategy
  @@ip_authorization_strategy = nil

  # Configure Mango Handcart using a block
  def self.configure
    yield self
  end

  def self.handcart_class
    @@handcart_class.constantize
  end

  def self.dns_record_class
    @@dns_record_class.constantize
  end

  def self.ip_authorization
    IpAuthorization.instance
  end

end
