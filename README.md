Ruby 2.4.2

Rails 5.1.4
	
一些记录

	gem uninstall bcrypt
	gem uninsall bcrypt-ruby
	gem install bcrypt --platform=ruby

记得bundle install
	

生成public下的静态资源,需要修正字体的资源文件夹asset为fonts

	rake assets:precompile RAILS_ENV=production

运行

	bundle exec rackup sync.ru -E production --host localhost
	