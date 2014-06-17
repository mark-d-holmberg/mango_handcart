class PublicController < ApplicationController
  layout 'public'

  enable_forwarding("franchisee#index", "public#forbidden", only: [:index])

  def index
  end

  def forbidden
  end

  def blocked
    flash[:error] = "Your IP address has been blocked from accessing the system."
  end

end
