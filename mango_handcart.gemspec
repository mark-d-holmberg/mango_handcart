$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mango_handcart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mango_handcart"
  s.version     = MangoHandcart::VERSION
  s.authors     = ["Mark D Holmberg"]
  s.email       = ["mark.d.holmberg@gmail.com"]
  s.homepage    = "https://github.com/mark-d-holmberg/mango_handcart"
  s.summary     = "Mango Handcart manages subdomains for Mango Voice 2"
  s.description = "This is the implementation of Handcart for Mango Voice 2"
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 4.1.1"

  s.add_development_dependency "pg"
  s.add_development_dependency "rspec-rails"
end
