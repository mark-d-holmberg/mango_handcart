# config/initializers/mango_handcart.rb

# Setup Mango Handcart Gem here
MangoHandcart.configure do |config|

  # Setup the domain constraints (Default: [])
  # config.domain_constraints = ["dummy.dev"]

  # Enable/Disable A-Record domain lookups (Default: false)
  # config.enable_a_record_lookups = false

  # The list of subdomains which cannot be assigned to a DNS record
  # config.reserved_subdomains = ["www", "ftp", "ssh", "pop3", "dev", "master", "customer", "reseller", "admin"]

  # This MUST be set in order for Mango Handcart to work properly.
  # Set it to the value of the class which will call `acts_as_handcart`
  # config.handcart_class = "Company"

  # Set this to change where the handcart show route is
  # config.handcart_show_path = "companies"

  # Set the strategy to use for IP Authorization
  config.ip_authorization_strategy = :inclusion

  # What Rails environments enable IP blocking and blacklisting
  config.global_ip_blocking_enabled_environments = ["staging", "production"]

  # What Rails environments enable IP forwarding and forbidden redirects
  config.global_ip_forwarding_enabled_environments = ["staging", "production"]

end
