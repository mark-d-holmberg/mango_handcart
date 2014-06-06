require "mango_handcart/engine"
require "mango_handcart/domain_constraint"
require 'haml'
require "mango_handcart/simple_form"
require 'jquery-rails'
require 'bootstrap-sass'
require 'kaminari'

module MangoHandcart

  mattr_accessor :domain_constraints
  @@domain_constraints = []

  def self.configure
    yield self
  end

end
