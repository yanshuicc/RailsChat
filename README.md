Ruby 2.4.2

Rails 5.1.4

生成public下的静态资源

	rake assets:precompile RAILS_ENV=production

运行

	bundle exec rackup sync.ru -E production --host localhost
	gem uninstall bcrypt
	gem uninsall bcrypt-ruby
	gem install bcrypt --platform=ruby
