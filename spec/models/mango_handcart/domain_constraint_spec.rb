require 'spec_helper'

module MangoHandcart

  shared_examples "a domain constraint" do
    it "should be able to read its domain" do
      expect(constraint.domain).to eq("dummy.test")
    end

    it "should add it to MangoHandcart's module variable" do
      expect(MangoHandcart.domain_constraints).to include(constraint.domain)
    end

    describe "concerning the controller and route matching" do
      before(:each) do
        @request = ActionController::TestRequest.new
        @request.host = "dummy.test"
      end

      it "should have a matches? method" do
        expect(@request.domain).to eq("dummy.test")
        expect(constraint.matches?(@request)).to eq(true)
      end
    end

  end

  describe DomainConstraint do
    it_behaves_like "a domain constraint" do
      let(:constraint) { DomainConstraint.new("dummy.test") }
    end

    it "should have a default domain constraint" do
      expect(DomainConstraint.default_constraint).to_not be_nil
      expect(DomainConstraint.default_constraint.domain).to eql("dummy.test")
    end
  end
end
