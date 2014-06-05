require "mango_handcart/engine"
require "mango_handcart/domain_constraint"

module MangoHandcart

  mattr_accessor :domain_constraints
  @@domain_constraints = []

  def self.configure
    yield self
  end

end
