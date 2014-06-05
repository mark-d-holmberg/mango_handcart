module MangoHandcart

  class DomainConstraint
    attr_reader :domain

    def initialize(domain)
      @domain = domain
      MangoHandcart.domain_constraints << @domain unless MangoHandcart.domain_constraints.include?(@domain)
    end

    def matches?(request)
      MangoHandcart.domain_constraints.include?(request.domain)
    end

    def self.default_constraint
      DomainConstraint.new(MangoHandcart::Engine::CONFIG[:domain_constraint])
    end
  end

end
