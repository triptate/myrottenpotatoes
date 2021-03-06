source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.8'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use ProtectedAttributes to keep attr_accessible method
gem 'protected_attributes'

# Use Haml for templates
gem 'haml'

# Use omniauth to authenticate users
gem 'omniauth'
gem 'omniauth-twitter'

# Use themoviedb for movie data search
gem 'themoviedb'

# On development & test, use the byebug debugger and sqlite3 database
group :development, :test do
  gem 'byebug'
  gem 'sqlite3'
end

# On production, use the postgresql database
group :production do
  gem 'pg'
end

# On test, use Cucumber, Capybara, RSpec and related tools
group :test do
  gem 'cucumber-rails', :require => false
  gem 'cucumber-rails-training-wheels'  # some pre-fabbed step definitions
  gem 'database_cleaner'  # to clear Cucumber's test database between runs
  gem 'capybara'  # lets Cucumber pretend to be a web browser
  gem 'launchy'  # a useful debugging aid for user stories
  gem 'rspec-rails'
  gem 'rspec-activemodel-mocks'  # for using the mock_model methods in tests
  gem 'rspec-its'  # for using the its methods in tests
  gem 'autotest-rails'
  gem 'factory_girl_rails'  # for creating factories instead of fixtures
  gem 'simplecov'
end

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',        group: :development

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
