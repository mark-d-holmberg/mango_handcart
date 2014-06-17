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

    describe "concerning associations" do
      it "should have one company" do
        dns_record = create(:mango_handcart_dns_record, subdomain: 'mark')
        company = create(:company, dns_record: dns_record)
        expect(dns_record.handcart).to eq(company)
      end
    end

    describe "concerning scopes" do
      it 'should have an allocated scope' do
        dns_record = create(:mango_handcart_dns_record, subdomain: 'mark')
        company = create(:company, dns_record: dns_record)
        expect(DnsRecord.allocated).to match_array([dns_record])
      end

      it "should have an unallocated scope" do
        dns_record = create(:mango_handcart_dns_record, subdomain: 'mark')
        expect(dns_record.handcart).to be_nil
        expect(DnsRecord.unallocated).to match_array([dns_record])
      end

      it "should have an unallocated or current scope" do
        unallocated = create(:mango_handcart_dns_record, subdomain: 'mark')
        current = create(:mango_handcart_dns_record, subdomain: 'holmberg')
        company = create(:company, dns_record: current)
        expect(unallocated.handcart).to be_nil
        expect(current.handcart).to_not be_nil
        expected = DnsRecord.unallocated_or_current(company)
        expect(DnsRecord.unallocated_or_current(company)).to match_array([current, unallocated])
      end
    end

    describe "concerning activation of handcarts" do
      describe "concerning handcarts that dont respond_to :active?" do
        before(:each) do
          @dns_record = create(:mango_handcart_dns_record, subdomain: 'example')
          @company = create(:company, dns_record: @dns_record, active: true)
          @request = ActionController::TestRequest.new
          @request.host = "example.dummy.dev"
          allow(@company).to receive(:active?).and_return(true)
        end

        it "should return true if the handcart doesnt respond_to :active?" do
          expect(DnsRecord.matches?(@request)).to eq(true)
          expect(@company).to respond_to(:active?)
        end
      end

      describe "concering handcarts that do respond_to :active?" do
        before(:each) do
          @dns_record = create(:mango_handcart_dns_record, subdomain: 'example')
          @company = create(:company, dns_record: @dns_record)
          @request = ActionController::TestRequest.new
          @request.host = "example.dummy.dev"
        end

        it "should return true if it is active" do
          allow(@company).to receive(:active?).and_return(true)
          expect(@company).to respond_to(:active?)
          expect(@company.active?).to eq(true)
          expect(DnsRecord.matches?(@request)).to eq(true)
        end

        it "should return false if it is NOT active" do
          @company.update(active: false)
          expect(@company).to respond_to(:active?)
          expect(@company.active?).to eq(false)
          expect(DnsRecord.matches?(@request)).to eq(false)
        end
      end
    end

  end
end
