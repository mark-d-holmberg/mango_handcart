require 'spec_helper'

module MangoHandcart
  describe IpAuthorization do
    it "should set the strategy variable to the engine's strategy" do
      expect(MangoHandcart.ip_authorization).to_not be_nil
      expect(MangoHandcart.ip_authorization.ip_authorization_strategy).to eq(:inclusion)
    end

    it "should set the strategy to a class" do
      expect(MangoHandcart.ip_authorization).to_not be_nil
      expect(MangoHandcart.ip_authorization.strategy).to_not be_nil
      expect(MangoHandcart.ip_authorization.strategy.class).to eq(MangoHandcart::Strategies::InclusionStrategy)
      expect(MangoHandcart.ip_authorization.strategy.strategy).to eq(:inclusion)
    end
  end
end
