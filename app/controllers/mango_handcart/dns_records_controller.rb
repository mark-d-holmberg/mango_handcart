require_dependency "mango_handcart/application_controller"

module MangoHandcart
  class DnsRecordsController < ApplicationController
    before_action :set_dns_record, only: [:show, :edit, :update, :destroy]

    def index
      @dns_records = DnsRecord.all
      @dns_records = @dns_records.page(params[:page])
    end

    def show
    end

    def new
      @dns_record = DnsRecord.new
    end

    def edit
    end

    def create
      @dns_record = DnsRecord.new(safe_params)

      if @dns_record.save
        redirect_to @dns_record, notice: 'DNS Record was successfully created.'
      else
        render :new
      end
    end

    def update
      if @dns_record.update(safe_params)
        redirect_to @dns_record, notice: 'DNS Record was successfully updated.'
      else
        render :edit
      end
    end

    def destroy
      @dns_record.destroy
      redirect_to dns_records_url, notice: 'DNS Record was successfully removed.'
    end


    private

    def set_dns_record
      @dns_record = DnsRecord.find(params[:id])
    end

    def safe_params
      safe_attributes = [:name, :subdomain, :domain, :tld_size, :active]
      params.require(:dns_record).permit(safe_attributes)
    end

  end
end
