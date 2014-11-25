source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.1.8'

gem 'rails-api'

gem 'spring', :group => :development


gem 'pg'

gem 'nokogiri'


# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

gem 'rspec-rails', :group => :test

gem "foreman"

group :production, :staging do
  gem "rails_12factor"
  gem "rails_stdout_logging"
  gem "rails_serve_static_assets"
end

group :assets do
  gem 'therubyracer'
  gem 'uglifier'
end