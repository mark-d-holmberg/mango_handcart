require 'spec_helper'

module MangoHandcart
  module Strategies
    describe BaseIpStrategy do
      let(:my_strategy) { BaseIpStrategy.new }

      it "should have none for the strategy" do
        expect(my_strategy.strategy).to eq(:none)
      end

      it "should throw an error if they use it for ip authorization" do
        expect { my_strategy.is_in_range?("255.255.255.0", nil) }.to raise_error(NotImplementedError)
      end

      it "should know the available_strategies" do
        expect(BaseIpStrategy.available_strategies).to include(:none)
        expect(BaseIpStrategy.available_strategies).to include(:inclusion)
        expect(BaseIpStrategy.available_strategies).to include(:containment)
      end
    end
  end
end
