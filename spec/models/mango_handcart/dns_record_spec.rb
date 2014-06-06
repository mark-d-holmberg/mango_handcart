require 'spec_helper'

module MangoHandcart
  RSpec.describe DnsRecord, type: :model do
    describe "concerning validations" do
      it "has a valid factory" do
        expect(build(:mango_handcart_dns_record)).to be_valid
      end

      it "requires a name" do
        expect(build(:mango_handcart_dns_record, name: nil)).to_not be_valid
      end
    end
  end
end
