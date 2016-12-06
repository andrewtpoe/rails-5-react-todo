source 'https://rubygems.org'
ruby "2.3.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# These gems will provide styling for the application
gem "animate-css-rails"
gem "autoprefixer-rails"
gem "blaze-css-rails"
gem "font-awesome-rails"

# devise provides user authentication
gem "devise"

# haml replaces erb as the templating tool within rails.
gem "haml"


group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  # gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # better_errors provides error reporting and a console in the browser when an error is raised
  gem "better_errors"
  # foreman is used to start multiple web processes when the server is booted up.
  gem "foreman"
  # yard is used for documentation within the code.
  gem "yard"
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platform: :mri

  # I prefer pry to byebug. I also use .pow on every project
  # pry-remote allows you to use pry and .pow together.
  gem "pry"
  gem "pry-remote"
  gem "pry-stack_explorer"
end


group :test do
  # These tools are used to test the application from Ruby. There will be another set of tools
  # used to test the javascript.
  gem "capybara"
  gem "capybara-screenshot"
  gem "poltergeist"
  gem "rails-controller-testing"
  gem "rspec-rails", "~> 3.5"
end


# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
