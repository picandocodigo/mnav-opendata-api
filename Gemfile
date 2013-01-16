source 'http://rubygems.org'

gem 'rails', '3.2.11'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'rspec-rails'
  gem 'nyan-cat-formatter'
  gem 'nokogiri'
  gem 'simplecov', :require => false, :group => :test
end

group :development do
  gem 'rspec-rails'
  gem 'nyan-cat-formatter'
  gem 'debugger'
  gem 'sqlite3'
end

group :production do
  gem "pg"
end
