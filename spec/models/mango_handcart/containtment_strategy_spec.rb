require 'spec_helper'

module MangoHandcart
  module Strategies
    describe ContainmentStrategy do
      let(:my_strategy) { ContainmentStrategy.new }

      it "should have none for the strategy" do
        expect(my_strategy.strategy).to eq(:containment)
      end

      it "authorize IP addresses that are only contained in the list" do
        company = create(:company, name: "Planet Express")
        ip1 = create(:mango_handcart_ip_address, handcart: company)
        ip2 = create(:mango_handcart_ip_address, handcart: company)
        expect(company.ip_addresses.permitted).to include(ip1)
        expect(company.ip_addresses.permitted).to include(ip2)
        expect(my_strategy.is_in_range?(ip1, company)).to eq(true)
        expect(my_strategy.is_in_range?(ip2, company)).to eq(true)
      end
    end
  end
end
