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

  s.add_dependency "rails", ">= 3.0.0"

  if RUBY_VERSION >= "2.5.0"
    s.add_dependency "sassc-rails"
  else
    s.add_dependency "sass-rails", ">= 4", "< 6"
  end

  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "appraisal"
  s.add_development_dependency "byebug"
end
