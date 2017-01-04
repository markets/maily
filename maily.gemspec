require "./lib/maily/version"

Gem::Specification.new do |s|
  s.name          = "maily"
  s.version       = Maily::VERSION
  s.authors       = ["markets"]
  s.email         = ["srmarc.ai@gmail.com"]
  s.homepage      = "https://github.com/markets/maily"
  s.summary       = "Rails Engine to preview emails in the browser."
  s.description   = "Rails Engine to preview, follow up, test and edit the emails of your applications in the browser"
  s.license       = "MIT"

  s.files         = `git ls-files`.split($/)
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.test_files    = s.files.grep(%r{^(test|spec|features)/})
  s.require_paths = ["lib"]

  s.add_dependency "rails", ">= 3.0.0"

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "appraisal"
  s.add_development_dependency 'test-unit', '~> 3.0'
  s.add_development_dependency "byebug" if RUBY_VERSION.to_i >= 2
end
