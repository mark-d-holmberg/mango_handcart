require 'spec_helper'

module MangoHandcart
  describe MangoHandcart do

    describe "concerning the default domain constraint" do
      it "should respond to the domain_constraints method" do
        expect(MangoHandcart.respond_to?(:domain_constraints)).to eql(true)
      end

      it "should default the default domain_constraints to dummy.dev" do
        expect(MangoHandcart.domain_constraints).to eql(["dummy.test"])
      end
    end

    describe "concerning configuring the gem using a block" do
      it "should respond_to configure" do
        expect(MangoHandcart.respond_to?(:configure)).to eql(true)
      end

      it "should have an attribute for a-record lookups" do
        expect(MangoHandcart.enable_a_record_lookups).to eql(false)
      end

      it "should know the handcart_class" do
        expect(MangoHandcart.handcart_class).to eq(Company)
      end

      it "knows the handcart_show_path" do
        expect(MangoHandcart.handcart_show_path).to be_nil
      end
    end

    describe "concerning IP Authorization" do
      it "should not enforce IP Authorization by default" do
        expect(MangoHandcart.ip_authorization_strategy).to_not be_nil
        expect(MangoHandcart.ip_authorization_strategy).to eq(:inclusion)
      end

      it "should have an IP Authorization singleton" do
        expect(MangoHandcart.ip_authorization).to_not be_nil
      end
    end

    describe "concerning IP Forwarding and Blocking" do
      it "should know the global_ip_blocking_enabled_environments" do
        expect(MangoHandcart.global_ip_blocking_enabled_environments).to match_array(["development", "staging", "production"])
      end

      it "should know the global_ip_forwarding_enabled_environments" do
        expect(MangoHandcart.global_ip_forwarding_enabled_environments).to match_array(["development", "staging", "production"])
      end
    end

  end
end
