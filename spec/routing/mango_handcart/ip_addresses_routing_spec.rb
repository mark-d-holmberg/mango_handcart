require "spec_helper"

module MangoHandcart
  RSpec.describe IpAddressesController, type: :routing do
    describe "routing" do
      routes { MangoHandcart::Engine.routes }

      it "routes to #index" do
        expect(get: "/ip_addresses").to route_to("mango_handcart/ip_addresses#index")
      end

      it "routes to #new" do
        expect(get: "/ip_addresses/new").to route_to("mango_handcart/ip_addresses#new")
      end

      it "routes to #show" do
        expect(get: "/ip_addresses/1").to route_to("mango_handcart/ip_addresses#show", id: "1")
      end

      it "routes to #edit" do
        expect(get: "/ip_addresses/1/edit").to route_to("mango_handcart/ip_addresses#edit", id: "1")
      end

      it "routes to #create" do
        expect(post: "/ip_addresses").to route_to("mango_handcart/ip_addresses#create")
      end

      it "routes to #update" do
        expect(put: "/ip_addresses/1").to route_to("mango_handcart/ip_addresses#update", id: "1")
      end

      it "routes to #destroy" do
        expect(delete: "/ip_addresses/1").to route_to("mango_handcart/ip_addresses#destroy", id: "1")
      end

    end
  end
end
