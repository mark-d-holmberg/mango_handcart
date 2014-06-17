require 'spec_helper'

module MangoHandcart
  module Strategies
    describe InclusionStrategy do
      let(:my_strategy) { InclusionStrategy.new }
      let(:company) { create(:company, name: "Planet Express") }

      it "should have none for the strategy" do
        expect(my_strategy.strategy).to eq(:inclusion)
      end

      it "should allow an authorized IP address" do
        native_ip_address = create(:mango_handcart_ip_address, handcart: company, address: '10.10.9.1', subnet_mask: '255.255.255.128', blacklisted: false)
        expect(my_strategy.is_in_range?(IPAddr.new("10.10.9.8"), company)).to eq(true)
      end

      it "should reject an UNAUTHORIZED IP address" do
        native_ip_address = create(:mango_handcart_ip_address, handcart: company, address: '10.10.9.1', subnet_mask: '255.255.255.128', blacklisted: false)
        expect(my_strategy.is_in_range?(IPAddr.new("10.10.9.253"), company)).to eq(false)
      end

      it "should reject an AUTHORIZED BLACKLISTED IP address" do
        native_ip_address = create(:mango_handcart_ip_address, handcart: company, address: '10.10.9.1', subnet_mask: '255.255.255.128', blacklisted: true)
        expect(my_strategy.is_in_range?(IPAddr.new("10.10.9.8"), company)).to eq(false)
      end
    end
  end
end
