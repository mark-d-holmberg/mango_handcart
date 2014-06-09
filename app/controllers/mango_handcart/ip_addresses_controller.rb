require_dependency "mango_handcart/application_controller"

module MangoHandcart
  class IpAddressesController < ApplicationController
    before_action :set_ip_address, only: [:show, :edit, :update, :destroy]

    # GET /ip_addresses
    def index
      @ip_addresses = IpAddress.all
    end

    # GET /ip_addresses/1
    def show
    end

    # GET /ip_addresses/new
    def new
      @ip_address = IpAddress.new
    end

    # GET /ip_addresses/1/edit
    def edit
    end

    # POST /ip_addresses
    def create
      @ip_address = IpAddress.new(ip_address_params)

      if @ip_address.save
        redirect_to @ip_address, notice: 'Ip address was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /ip_addresses/1
    def update
      if @ip_address.update(ip_address_params)
        redirect_to @ip_address, notice: 'Ip address was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /ip_addresses/1
    def destroy
      @ip_address.destroy
      redirect_to ip_addresses_url, notice: 'Ip address was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_ip_address
        @ip_address = IpAddress.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def ip_address_params
        params.require(:ip_address).permit(:address, :subnet_mask, :handcart_id, :blacklisted)
      end
  end
end
