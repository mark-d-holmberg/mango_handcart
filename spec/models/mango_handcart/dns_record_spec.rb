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

      it "should require a unique subdomain" do
        expect(create(:mango_handcart_dns_record, subdomain: 'mark')).to be_valid
        expect(build(:mango_handcart_dns_record, subdomain: 'mark')).to_not be_valid
      end

      it "should require a unique subdomain regardless of case" do
        expect(create(:mango_handcart_dns_record, subdomain: 'mark')).to be_valid
        expect(build(:mango_handcart_dns_record, subdomain: 'MARK')).to_not be_valid
      end

      it "should not be valid if the subdomain is reserved" do
        MangoHandcart.reserved_subdomains.each do |reserved_sub_domain|
          expect(build(:mango_handcart_dns_record, subdomain: reserved_sub_domain)).to_not be_valid
        end
      end
    end

    describe "concerning invalid characters" do
      it "should remove spaces in the subdomain" do
        expect(create(:mango_handcart_dns_record, subdomain: 'this has spaces').subdomain).to eq("thishasspaces")
        expect(create(:mango_handcart_dns_record, subdomain: 'this    has s p   aces').subdomain).to eq("thishasspaces")
      end

      it "should remove the '+'' character" do
        expect(create(:mango_handcart_dns_record, subdomain: 'this has a + in it').subdomain).to eq("thishasainit")
      end

      it "should remove the '/' character" do
        expect(create(:mango_handcart_dns_record, subdomain: 'this has a / in it').subdomain).to eq("thishasainit")
      end

      it "should remove the '=' character" do
        expect(create(:mango_handcart_dns_record, subdomain: 'this has a = in it').subdomain).to eq("thishasainit")
      end

      it "should remove the '?' character" do
        expect(create(:mango_handcart_dns_record, subdomain: 'this has a ? in it').subdomain).to eq("thishasainit")
      end
    end

    describe "concerning reserved subdomains" do
      it "can list the reserved subdomains" do
        expect(MangoHandcart.reserved_subdomains).to eq(["www", "ftp", "ssh", "pop3", "dev", "master", "customer", "reseller", "admin"])
      end
    end

    describe "when a-record lookups are ENABLED" do
      before(:each) do
        @request = ActionController::TestRequest.new
        @record_1 = create(:mango_handcart_dns_record, name: 'Alpha', domain: "dummy.test", subdomain: "alpha")
        @record_2 = create(:mango_handcart_dns_record, name: 'Bravo', domain: "dummy.test", subdomain: "bravo")
        MangoHandcart.enable_a_record_lookups = true
      end

      it "should ensure that a-record support is on" do
        expect(MangoHandcart.enable_a_record_lookups).to eql(true)
      end

      it "should allow you to create a dns_record with the a duplicate subdomain" do
        expect(build(:mango_handcart_dns_record, name: 'Charlie', domain: "dummy.test", subdomain: "bravo")).to be_valid
      end

      it "should be able to find a duplicate subdomain but scoped to a different domain" do
        record = create(:mango_handcart_dns_record, name: 'Charlie', domain: "idiot.test", subdomain: "bravo")
        @request.host = "bravo.idiot.test"
        expect(DnsRecord.lookup(@request)).to eql(record)
      end

      it "should be able to find them by the domain AND subdomain" do
        @request.host = "alpha.dummy.test"
        expect(DnsRecord.lookup(@request)).to eql(@record_1)
      end
    end

    describe "when a-record lookups are DISABLED" do
      before(:each) do
        @request = ActionController::TestRequest.new
        MangoHandcart.enable_a_record_lookups = false
        @record_1 = create(:mango_handcart_dns_record, name: 'Alpha', domain: "idiot.test", subdomain: "alpha")
        @record_2 = create(:mango_handcart_dns_record, name: 'Bravo', domain: "idiot.test", subdomain: "bravo")
      end

      it "should ensure that a-record support is off" do
        expect(MangoHandcart.enable_a_record_lookups).to eql(false)
      end

      it "should NOT allow duplicate subdomains" do
        expect(build(:mango_handcart_dns_record, name: 'Charlie', domain: "idiot.test", subdomain: "bravo")).to_not be_valid
      end

      it "should be able to find them by the subdomain" do
        # This is the hard case
        @request.host = "bravo.idiot.test"
        expect(DnsRecord.lookup(@request)).to eql(@record_2)
      end
    end

  end
end
