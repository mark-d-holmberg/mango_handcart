require_dependency "mango_handcart/application_controller"

module MangoHandcart
  class IpAddressesController < ApplicationController
    before_action :set_ip_address, only: [:show, :edit, :update, :destroy]

    def index
      @ip_addresses = IpAddress.all
      @ip_addresses = @ip_addresses.page(params[:page])
    end

    def show
    end

    def new
      @ip_address = IpAddress.new
    end

    def edit
    end

    def create
      @ip_address = IpAddress.new(safe_params)

      if @ip_address.save
        redirect_to @ip_address, notice: 'IP Address was successfully created.'
      else
        render :new
      end
    end

    def update
      if @ip_address.update(safe_params)
        redirect_to @ip_address, notice: 'IP Address was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @ip_address.destroy
      redirect_to ip_addresses_url, notice: 'IP Address was successfully removed.'
    end


    private

    def set_ip_address
      @ip_address = IpAddress.find(params[:id])
    end

    def safe_params
      safe_attributes = [:address, :subnet_mask, :handcart_id, :blacklisted]
      params.require(:ip_address).permit(safe_attributes)
    end

  end
end
