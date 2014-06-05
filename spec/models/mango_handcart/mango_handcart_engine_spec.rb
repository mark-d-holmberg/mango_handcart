require 'spec_helper'

module MangoHandcart
  describe MangoHandcart::Engine do
    it "should have a config file" do
      expect(MangoHandcart::Engine::CONFIG).to_not be_nil
    end

    it "should have a default domain constraint" do
      expect(MangoHandcart::Engine::CONFIG).to have_key(:domain_constraint)
    end
  end

end
