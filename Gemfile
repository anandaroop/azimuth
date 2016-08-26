source 'https://rubygems.org'
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

def artsy_internal_repo_url(repo)
  gem repo, git: "https://#{ENV['artsy_github_oauth_token']}:x-oauth-basic@github.com/artsy/#{repo}.git"
end

gem 'foreman'
gem 'omniauth-oauth2'
gem 'oauth2', { git: 'https://github.com/matthewrudy/oauth2.git', branch: 'rack2' }
gem 'omniauth-artsy', git: 'https://github.com/artsy/omniauth-artsy.git'
gem 'kinetic', { git: 'https://github.com/artsy/kinetic.git' }
gem 'typhoeus', '0.7.1'
gem 'ethon', git: 'https://github.com/dylanfareed/ethon.git'
gem 'active_attr'
gem 'haml-rails'

watt_gem_spec = { git: 'https://github.com/artsy/watt.git', branch: 'master' }
# watt_gem_spec = { path: '../watt' }
gem 'watt', watt_gem_spec
gem 'bootstrap-sass'
gem 'bourbon'
gem 'neat'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'dotenv-rails'
  gem 'byebug', platform: :mri
  gem 'rubocop'
  gem 'rspec'
  gem 'rspec-rails'
  gem 'fabrication'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec', require: false
  gem 'guard-livereload'
end

group :test do
  gem 'capybara'
  gem 'rack_session_access'
  gem 'rails-controller-testing' # assigns and assert_template moved out of ActionDispatch
  gem 'webmock'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
