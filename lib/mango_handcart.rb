require "mango_handcart/engine"
require "mango_handcart/domain_constraint"
require "mango_handcart/setting_constraint"
require "mango_handcart/acts_as_handcart"
require "mango_handcart/simple_form"
require 'haml'
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

  # Which class will invoke a call to `acts_as_handcart`
  mattr_accessor :handcart_class
  @@handcart_class = nil

  # What view_path can I use to view the handcart?
  mattr_accessor :handcart_show_path
  @@handcart_show_path = nil

  # What class is used for the Subdomain/Domain matching?
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
