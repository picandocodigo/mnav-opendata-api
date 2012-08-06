source 'http://rubygems.org'

gem 'rails', '3.1.7'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

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
