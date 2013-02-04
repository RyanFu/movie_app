if RUBY_VERSION =~ /1.9/
  Encoding.default_external = Encoding::UTF_8
  Encoding.default_internal = Encoding::UTF_8
end
source 'https://rubygems.org'

gem 'rails', '3.2.11'


#資料庫相關
gem 'mysql2', '~> 0.3.6'
gem 'yaml_db'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'


# api
gem 'rabl'

#user
gem 'devise'

# 爬蟲
gem 'nokogiri'

gem 'koala'

group :test, :development do
  gem "rspec"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "shoulda-matchers"
  gem "bullet"
end

gem 'capistrano'
gem 'capistrano-ext'

gem 'gcm_on_rails'

gem 'newrelic_rpm'

# 效能相關
gem 'cells'
gem 'sneaky-save'

# cron table
gem 'whenever', :require => false

gem 'delayed_job_active_record'
gem "daemons"

#分頁
gem 'will_paginate'

gem 'dropbox-sdk'