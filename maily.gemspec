require "./lib/maily/version"

Gem::Specification.new do |s|
  s.name          = "maily"
  s.version       = Maily::VERSION
  s.authors       = ["markets"]
  s.email         = ["srmarc.ai@gmail.com"]
  s.homepage      = "https://github.com/markets/maily"
  s.summary       = "Rails Engine to preview emails in the browser."
  s.description   = "Maily is a Rails Engine to manage, test and navigate through all your email templates of your app, being able to preview them directly in your browser."
  s.license       = "MIT"

  s.files         = Dir["{app,config,lib}/**/*"] + %w[README.md CHANGELOG.md MIT-LICENSE]
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 4.2"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "appraisal"
end
