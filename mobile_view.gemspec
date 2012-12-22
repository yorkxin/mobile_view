require File.expand_path('../lib/mobile_view/version', __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mobile_view"
  s.version     = MobileView::VERSION
  s.authors     = ["Yu-Cheng Chuang"]
  s.email       = ["ducksteven@gmail.com"]
  s.homepage    = "TODO"
  s.summary     = "View template for mobile devices made easy."
  s.description = "Easily specify mobile view template for mobile devices."

  s.files       = `git ls-files`.split($\)
  s.test_files  = s.files.grep(%r{^(test|spec|features)/})

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "rack-mobile-detect", "~> 0.4.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "capybara"

  s.require_paths = ["lib"]
end
