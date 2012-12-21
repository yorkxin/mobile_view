$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobile_view/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobile_view"
  s.version     = MobileView::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of MobileView."
  s.description = "TODO: Description of MobileView."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
end
