require "mango_handcart/engine"
require "mango_handcart/domain_constraint"
require 'haml'
require "mango_handcart/simple_form"
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

  # Configure Mango Handcart using a block
  def self.configure
    yield self
  end

end
