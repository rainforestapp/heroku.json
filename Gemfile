source 'https://rubygems.org'

# Specify your gem's dependencies in heroku.json.gemspec
gemspec

group :development do
  gem "rake",  ">= 0.8.7"
end

group :test do
  gem "jruby-openssl", :platform => :jruby
  gem "json"
  gem "rake",  ">= 0.8.7"
  gem "rspec", ">= 2.0"
  gem "webmock"
  gem "vcr"
end