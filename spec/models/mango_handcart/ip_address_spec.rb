require 'rails_helper'

module MangoHandcart
  RSpec.describe IpAddress, type: :model do

    describe "concerning validations" do
      it "should have a valid factory" do
        expect(build(:mango_handcart_ip_address)).to be_valid
      end

      it "should require an address" do
        expect(build(:mango_handcart_ip_address, address: nil)).to_not be_valid
      end

      it "should require a unique address" do
        expect(create(:mango_handcart_ip_address, address: "10.10.9.1")).to be_valid
        expect(build(:mango_handcart_ip_address, address: "10.10.9.1")).to_not be_valid
      end

      it "should require a properly formatted address" do
        expect(build(:mango_handcart_ip_address, address: "256.256.256.256")).to_not be_valid
      end

      it "should require a subnet mask" do
        expect(build(:mango_handcart_ip_address, subnet_mask: nil)).to_not be_valid
      end

      it "should require a properly formatted subnet mask" do
        expect(build(:mango_handcart_ip_address, subnet_mask: "256.256.256.256")).to_not be_valid
      end

      it "should not allow two handcarts to have the same IP" do
        sub_1 = create(:mango_handcart_dns_record, subdomain: 'planet')
        sub_2 = create(:mango_handcart_dns_record, subdomain: 'moms')
        company1 = create(:company, name: "Planet Express", dns_record: sub_1)
        company2 = create(:company, name: "Moms Friendly Robot Company", dns_record: sub_2)
        expect(create(:mango_handcart_ip_address, handcart: company1, address: '10.10.9.1', subnet_mask: '255.255.255.128', blacklisted: false)).to be_valid
        expect(build(:mango_handcart_ip_address, handcart: company2, address: '10.10.9.1', subnet_mask: '255.255.255.128', blacklisted: false)).to_not be_valid
      end
    end

    describe "concerning relations" do
      it "should belong to the handcart" do
        company = create(:company, name: "Planet Express")
        ip_address = create(:mango_handcart_ip_address, handcart: company)
        expect(ip_address.handcart).to eq(company)
      end
    end

  end
end
