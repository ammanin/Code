source 'https://rubygems.org'

gem 'sinatra'
gem 'shotgun'
gem "rake"
gem 'activerecord'
gem 'sinatra-activerecord' # excellent gem that ports ActiveRecord for 
gem 'haml'
gem 'builder'
gem 'activesupport'
gem 'sinatra-contrib'
gem 'twilio-ruby'
gem 'dotenv' 
gem 'dotenv-rails', :groups => [:development, :test]
gem 'json'
gem 'bundler'
# to avoid installing postgres use 
# bundle install --without production
gem "sqlite3"

group :development, :test do
  gem 'sqlite3'
  gem 'dotenv'
end

group :production do
  gem 'pg'
end

