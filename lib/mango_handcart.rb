require "mango_handcart/engine"
require "mango_handcart/domain_constraint"
require 'haml'
require "mango_handcart/simple_form"
require "mango_handcart/acts_as_handcart"
require 'jquery-rails'
require 'bootstrap-sass'
require 'kaminari'

module MangoHandcart

  # The domain constraints for route matching
  mattr_accessor :domain_constraints
  @@domain_constraints = []

  # Do we match on the subdomain AND domain? (A-Records)
  mattr_accessor :enable_a_record_lookups
  @@enable_a_record_lookups = false

  # The subdomains which cannot be assigned to a DNS record
  mattr_accessor :reserved_subdomains
  @@reserved_subdomains = []

  mattr_accessor :handcart_class
  @@handcart_class = nil

  mattr_accessor :dns_record_class
  @@dns_record_class = "MangoHandcart::DnsRecord"

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

end
