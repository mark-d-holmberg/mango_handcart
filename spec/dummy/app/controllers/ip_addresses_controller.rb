class IpAddressesController < ApplicationController

  def index
    @ip_addresses = current_handcart.ip_addresses.permitted
  end

end
