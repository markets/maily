$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "maily/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name          = "maily"
  s.version       = Maily::VERSION
  s.authors       = ["markets"]
  s.email         = ["srmarc.ai@gmail.com"]
  s.homepage      = "https://github.com/markets/jekyll-timeago"
  s.summary       = "Rails Engine to follow up application emails."
  s.description   = "Rails Engine to follow up application emails."
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", "~> 3.2.13"
end
