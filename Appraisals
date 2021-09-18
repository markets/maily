%w(
  6.1
  6.0
  5.2
).each do |version|
  appraise "rails-#{version}" do
    gem "rails", "~> #{version}.0"
  end
end

appraise "rails-head" do
  gem "rails", github: "rails/rails", branch: "main"
end
