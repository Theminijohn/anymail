source 'https://rubygems.org'

# Versions
ruby '2.1.2'
gem 'rails', '4.1.1'

# Standards
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'

# FrontEnd
gem 'font-awesome-rails', '~> 4.1.0.0'
gem 'bootstrap-sass', '~> 3.2.0.0'
gem 'autoprefixer-rails'

group :development, :test do
  gem 'spring'
  gem 'thin', '~> 1.6.2'
  gem 'sqlite3'
  gem 'quiet_assets'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-livereload', require: false
  gem 'rspec-rails', '~> 2.14.1'
  gem 'pry', '~> 0.10.0'
end

group :test do
  gem 'factory_girl_rails', '~> 4.4.1'
  gem 'faker', '~> 1.3.0'
  gem 'capybara', '~> 2.3.0'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner', '~> 1.3.0'
  gem 'launchy', '~> 2.4.2'
  gem 'selenium-webdriver', '~> 2.42.0'
  gem 'shoulda-matchers', require: false
end

group :production do
  gem 'pg'
  gem 'rails_12factor'
end