source 'https://rubygems.org'

ruby '2.2.7'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.7'

# Use postgresql as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
# gem 'sass-rails', '4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'jquery-turbolinks'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Source Map
# gem 'coffee-rails-source-maps'
# gem 'sass-rails-source-maps'

# CSS Support
# gem 'less-rails'

# App Server
gem 'puma'

# Haml（使わない）
# gem 'haml-rails'

# Assets log cleaner
gem 'quiet_assets'

# Form Builders
gem 'simple_form'

# # Process Management
gem 'foreman'

# HTML5 Validator
gem 'html5_validators'

# PG/MySQL Log Formatter
gem 'rails-flog'

# Migration Helper
gem 'migrant'

# Pagenation
gem 'kaminari'

# NewRelic
gem 'newrelic_rpm'

# Airbrake
# gem 'airbrake'

# HTML Parser
gem 'nokogiri'

# App configuration
gem 'figaro'

# Rack Profiler
gem 'rack-mini-profiler'


# Syntax Highlight
gem "redcarpet" # parse Markdown
gem "pygments.rb" # parse

# Tag Function
gem 'acts-as-taggable-on', '~> 3.4'

# For use Cloudinary
# http://qiita.com/GenTamura84/items/38cf899827bba050a21c
gem 'carrierwave'
gem 'cloudinary'

gem 'disqus'

gem 'meta-tags'

# Use Sass 3.4 and above.
gem 'sass', '~> 3.4'

# Add the kickstart_rails gem
gem 'kickstart_rails', '~> 3'

# Add autoprefixer
gem 'autoprefixer-rails'

group :development do
  # Converter erb => haml
  # gem 'erb2haml'
end


group :devlopment, :test do
  # rails application preloader
  gem 'spring'

  # Railsコンソールの多機能版
  gem 'pry-rails'

  # pryの入力に色付け
  gem 'pry-coolline'

  # デバッカー
  gem 'pry-byebug'

  # Pryでの便利コマンド
  gem 'pry-doc'

  # PryでのSQLの結果を綺麗に表示
  gem 'hirb'
  gem 'hirb-unicode'

  # pryの色付けをしてくれる
  gem 'awesome_print'

  # Rspec
  gem 'rspec-rails'
  gem 'rake_shared_context'

  # fixtureの代わり
  gem "factory_girl_rails"

  # テスト環境のテーブルをきれいにする
  gem 'database_rewinder'

  # Guard
  gem 'guard-rspec'
  gem 'guard-spring'
end

group :production, :staging do
  # ログ保存先変更、静的アセット Heroku 向けに調整
  gem 'rails_12factor'
end
