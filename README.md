# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

生成public下的静态资源
rake assets:precompile RAILS_ENV=production

运行
bundle exec rackup sync.ru -E production --host localhost

      gem uninstall bcrypt
      gem uninsall bcrypt-ruby
gem install bcrypt --platform=ruby