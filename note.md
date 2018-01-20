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

faye本地运行

	bundle exec rackup sync.ru -E production --host localhost

faye服务器远程部署命令

	nohup bundle exec rackup sync.ru -E production --host 138.128.206.124 &

修正服务器权限

    chmod 755 .

修正文件或路径用户组

    chown mail:mail log2012.log

    chown -R mail:mail log2012.log

sqlite3相关语法


在db目录下，打开slqite3

    sqlite3 development.sqlite3

查看表结构

    .table

更新管理员账号

    update users set role=1 where id=1

## 测试

先准备测试数据库

    rails db:test:prepare

运行测试前要打开faye


	
博主blog

http://blog.csdn.net/ppp8300885/article/details/59109778

https://github.com/chrismccord/render_sync

https://github.com/jamesotron/faye-rails