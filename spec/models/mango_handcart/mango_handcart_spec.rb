require 'spec_helper'

module MangoHandcart

  describe MangoHandcart do
    it "should respond to the domain_constraints method" do
      expect(MangoHandcart.respond_to?(:domain_constraints)).to eql(true)
    end

    it "should default the default domain_constraints to dummy.dev" do
      expect(MangoHandcart.domain_constraints).to eql(["dummy.test"])
    end

    it "should respond_to configure" do
      expect(MangoHandcart.respond_to?(:configure)).to eql(true)
    end
  end

end
