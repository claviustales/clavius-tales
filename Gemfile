# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.7'

gem 'puma', '~> 6.4'
gem 'rack', '~> 3.1'

group :development, :test do
  gem 'rack-test', '~> 2.1'
  gem 'rake', '~> 13.2'
end

group :test do
  gem 'rspec', '~> 3.13'
  gem 'simplecov', '~> 0.22', require: false
end

group :development do
  gem 'rubocop', '~> 1.66', require: false
  gem 'rubocop-rake', '~> 0.7.0', require: false
  gem 'rubocop-rspec', '~> 3.0', require: false
end
