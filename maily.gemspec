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

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "byebug"
end
