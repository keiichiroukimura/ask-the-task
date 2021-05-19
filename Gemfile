source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'kaminari'
gem 'rails_12factor', group: :production
ruby '2.6.2'
gem 'rails', '~> 5.2.2'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'ransack'
gem 'bcrypt', '3.1.11'
group :development, :test do
  
  gem 'rails-erd'
  gem 'rails-i18n', '~> 5.1'
  gem 'faker'
  gem 'spring'
  gem "rspec-rails"
  gem 'spring-commands-rspec'
  gem "factory_bot_rails"
  gem 'faker'
  gem 'capybara', '~> 2.13'
  gem "database_cleaner"
  gem "launchy"
  gem 'selenium-webdriver'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end

group :test do
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
  gem 'pry-rails'
  gem 'pry-byebug'
  gem 'pry-doc'
end
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
