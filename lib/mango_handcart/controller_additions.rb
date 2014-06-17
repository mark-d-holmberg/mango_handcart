module MangoHandcart

  # This module is automatically included into all controllers.
  module ControllerAdditions
    module ClassMethods

      def enable_forwarding(forwarding, rejection, *args)
        self.class_variable_set(:@@forwarding_url, forwarding)
        self.class_variable_set(:@@rejection_url, rejection)

        options = args.extract_options!
        if MangoHandcart.global_ip_forwarding_enabled_environments.include?(Rails.env)
          before_action :setup_forwarding_resources, options.slice(:except, :only)
          before_action :forward_or_reject, options.slice(:except, :only)
        else
          # No forwarding is enabled
        end
      end

      # Enable IP Blocking on the sessions controller
      def enable_blocking(rejection, *args)
        options = args.extract_options!
        self.class_variable_set(:@@rejection_url, rejection)

        if MangoHandcart.global_ip_blocking_enabled_environments.include?(Rails.env)
          before_action :setup_blocking_resources, options.slice(:except, :only)
          before_action :allow_or_reject, options.slice(:except, :only)
        else
          # Do nothing, no blocking is enabled
        end
      end
    end

    # Instance Methods here
    def current_dns
      @current_dns = MangoHandcart::DnsRecord.lookup(request)
    end

    def current_handcart
      @current_handcart = current_dns.handcart
    end

    def self.included(base)
      base.extend ClassMethods
      base.helper_method :current_dns, :current_handcart
    end

    private

    def setup_forwarding_resources
      @forwarding_url = self.class.class_variable_get(:@@forwarding_url)
      @rejection_url = self.class.class_variable_get(:@@rejection_url)
    end

    def setup_blocking_resources
      @rejection_url = self.class.class_variable_get(:@@rejection_url)
    end

    def forward_or_reject
      # We assume the the rejection action is going to be on the public controller
      # since we wouldn't want to forward the rejection to the handcart
      my_forbidden_url = main_app.url_for({
        subdomain: '',
        host: MangoHandcart::DomainConstraint.default_constraint.domain,
        controller: @rejection_url.split("#").first,
        action: @rejection_url.split("#").last,
        trailing_slash: false,
      })

      # Look for the IP Address
      ip_address = MangoHandcart::IpAddress.permitted.find_by_address(request.remote_ip)
      if ip_address
        # Do we have a current_handcart for this foreign IP?...
        if ip_address.handcart.present?
          # Does it respond to enable_ip_blocking? and if so, is it disabled right now?
          if ip_address.handcart.respond_to?(:enable_ip_blocking?)
            truthiness = ip_address.handcart.present? && !ip_address.handcart.enable_ip_blocking?
          else
            # otherwise, it doesn't respond to it, so just make sure the handcart is present
            truthiness = ip_address.handcart.present?
          end
        end

        # Now do the forwarding
        if truthiness
          my_forwarding_url = main_app.url_for({
            subdomain: ip_address.handcart.dns_record.subdomain,
            host: MangoHandcart::DomainConstraint.default_constraint.domain,
            controller: @forwarding_url.split("#").first,
            action: @forwarding_url.split("#").last,
            trailing_slash: false,
          })
          redirect_to my_forwarding_url
        else
          # Franchisee hasn't been activated yet, or this IP Address isn't associated with a franchisee yet.
          flash[:error] = 'Cannot login from this IP address!'
          redirect_to my_forbidden_url
        end
      else
        # Blacklisted
        flash[:error] = "IP Address has not been authorized to access this site"
        redirect_to my_forbidden_url
      end
    end

    # Don't allow unauthorized or blacklisted foreign IP addresses to hit
    # what we assume is the session controller for the franchisee.
    def allow_or_reject
      # We assume the the rejection action is going to be on the public controller
      # since we wouldn't want to forward the rejection to the handcart
      my_rejection_url = main_app.url_for({
        # subdomain: '',
        host: MangoHandcart::DomainConstraint.default_constraint.domain,
        controller: @rejection_url.split("#").first,
        action: @rejection_url.split("#").last,
        trailing_slash: false,
      })

      # See if they have enable IP blocking if they respond to that.
      if current_handcart.respond_to?(:enable_ip_blocking?)
        truthiness = current_handcart.enable_ip_blocking?
      else
        # Default to true
        truthiness = true
      end

      if truthiness
        ip_address = current_handcart.ip_addresses.permitted.find_by_address(request.remote_ip)
        if ip_address
          if MangoHandcart.ip_authorization.strategy.is_in_range?(ip_address.address, current_handcart)
            # Do nothing, let them login
          else
            # # The strategy doesn't match
            redirect_to my_rejection_url
          end
        else
          # No IP Address was found
          redirect_to my_rejection_url
        end
      else
        # Do nothing, blocking mode is disabled
      end
    end

  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include MangoHandcart::ControllerAdditions
  end
end
