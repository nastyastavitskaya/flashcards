source 'https://rubygems.org'
ruby '2.2.3'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.4'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'

gem 'bootstrap-sass', '2.3.2.0'
gem 'font-awesome-sass'
gem 'simple_form'

# gem for parsing
gem 'nokogiri', "~> 1.6.6"

# authentication
gem 'sorcery'

gem 'validates_email_format_of'
gem 'bcrypt'
gem 'jquery-rails'

# app configuration using ENV
gem 'figaro'

# Upload files
gem 'carrierwave'

# Manipulate images
gem 'mini_magick'

# cloud services library
gem 'fog'
gem 'fog-aws'

gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

# Heroku deploy
gem 'rails_12factor', group: :production

# Levenshtein distance
gem 'levenshtein-ffi', require: 'levenshtein'

# Clean ruby syntax for writing and deploying cron jobs
gem 'whenever', require: false

# Find out which locale the user preferes by reading the languages they specified in their browser
gem 'http_accept_language'


group :development, :test do
  gem 'rspec-rails'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'timecop'
  gem 'shoulda-matchers'
  gem 'database_cleaner'
end