require "spec_helper"

RSpec.describe CustomConstraintsController, type: :routing do
  describe "routing" do

    describe "concerning companies with enabled features" do
      before(:each) do
        @dns_record = create(:mango_handcart_dns_record, subdomain: "enabled", active: true)
        @company = create(:company, name: "Enabled Company", dns_record: @dns_record, active: true)
        MangoHandcart::DnsRecord.stub(:matches?).and_return(true)
        Company.any_instance.stub(:enables?).with(:custom_constraints).and_return(true)
      end

      let(:url) { "http://enabled.dummy.test" }

      it "routes to #index" do
        expect(get: "#{url}/custom_constraints").to route_to("custom_constraints#index")
      end
    end

    describe "concerning companies with DISABLED features" do
      before(:each) do
        MangoHandcart::DnsRecord.stub(:matches?).and_return(true)
        Company.any_instance.stub(:enables?).with(:custom_constraints).and_return(false)
        @dns_record = create(:mango_handcart_dns_record, subdomain: "disabled")
        @company = create(:company, name: "Disabled Company", dns_record: @dns_record)
      end

      let(:url) { "http://disabled.dummy.test" }

      it "does NOT route to #index" do
        expect(get: "#{url}/custom_constraints").to_not route_to("custom_constraints#index")
      end
    end

  end
end
