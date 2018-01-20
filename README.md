## [部署地址](http://chenpei.science)

环境版本

ubuntu 16.4

Ruby 2.4.2

Rails 5.1.4


安装apache2、passenger、sqlite3

	sudo apt-get install sqlite3
	sudo apt-get install apache2
	sudo apt-get install -y libapache2-mod-passenger
	sudo a2enmod passenger
	sudo apache2ctl restart

配置项目
	git clone https://github.com/yanshuicc/RailsChat.git
	gem install bcrypt --platform=ruby
    gem install eventmachine --platform ruby
    bundle install
	
添加网站配置文件/etc/apache2/sites-available/science.conf

		<VirtualHost *:80>
			ServerName chenpei.science

			ServerAdmin yscc
			DocumentRoot /var/www/RailsChat/public
			RailsEnv development

			ErrorLog ${APACHE_LOG_DIR}/error-science.log
			CustomLog ${APACHE_LOG_DIR}/access-science.log combined

			<Directory "/var/www/RailsChat/public">
					Options FollowSymLinks
					Require all granted
			</Directory>
	</VirtualHost>


修正网站目录权限

		 sudo chown -R yscc:yscc /var/www/RailsChat/


生成public下的静态资源,需要修正字体的资源文件夹asset为fonts

	rake assets:precompile RAILS_ENV=production


faye服务器远程部署命令

	nohup bundle exec rackup sync.ru -E production --host IP &

