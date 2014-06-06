require "rails_helper"

module MangoHandcart
  RSpec.describe DnsRecordsController, type: :routing do
    describe "routing" do
      routes { MangoHandcart::Engine.routes }

      it "routes to #index" do
        expect(get: "/dns_records").to route_to("mango_handcart/dns_records#index")
      end

      it "routes to #new" do
        expect(get: "/dns_records/new").to route_to("mango_handcart/dns_records#new")
      end

      it "routes to #show" do
        expect(get: "/dns_records/1").to route_to("mango_handcart/dns_records#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/dns_records/1/edit").to route_to("mango_handcart/dns_records#edit", id: "1")
      end

      it "routes to #create" do
        expect(post: "/dns_records").to route_to("mango_handcart/dns_records#create")
      end

      it "routes to #update" do
        expect(put: "/dns_records/1").to route_to("mango_handcart/dns_records#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/dns_records/1").to route_to("mango_handcart/dns_records#destroy", id: "1")
      end

    end
  end
end
