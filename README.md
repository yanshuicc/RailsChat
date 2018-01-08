环境版本

Ruby 2.4.2

Rails 5.1.4


安装
    bundle install


一些记录，可忽略

	gem uninstall bcrypt
	gem uninsall bcrypt-ruby
	gem install bcrypt --platform=ruby
    gem install eventmachine --platform ruby
	

生成public下的静态资源,需要修正字体的资源文件夹asset为fonts

	rake assets:precompile RAILS_ENV=production

本地运行

	bundle exec rackup sync.ru -E production --host localhost

	nohup bundle exec rackup sync.ru -E production --host 138.128.206.124
	
	
博主blog

http://blog.csdn.net/ppp8300885/article/details/59109778

https://github.com/chrismccord/render_sync

https://github.com/jamesotron/faye-rails