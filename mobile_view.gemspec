$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "mobile_view/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobile_view"
  s.version     = MobileView::VERSION
  s.authors     = ["Yu-Cheng Chuang"]
  s.email       = ["ducksteven@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "View template for mobile devices made easy."
  s.description = "Easily specify mobile view template for mobile devices."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "rack-mobile-detect", "~> 0.4.0"
end
