source 'http://rubygems.org'
ruby '2.1.4'

gem 'rails', '3.2'
gem 'unicorn'

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'rspec-rails'
  gem 'nyan-cat-formatter'
  gem 'nokogiri'
  gem 'simplecov', :require => false, :group => :test
end

group :development do
  gem 'byebug'
  gem 'sqlite3'
end

group :production do
  gem "pg"
end
