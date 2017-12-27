class SessionsController < ApplicationController
  include SessionsHelper

  def login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎回来: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
    redirect_to root_url, :flash => flash
  end

  def register()
    flag1 = User.find_by_email(params[:session][:email].downcase)
    flag2 = User.find_by_name(params[:session][:name])
    if flag1 or flag2
      flash= {:info => '注册失败: 用户邮箱或用户名已经占用 :)'}
    else
      user = User.create(name:params[:session][:name],
                  email:params[:session][:email].downcase,
                  password_digest:User.digest(params[:session][:password]),
                  remember_digest:params[:session][:password],
                  sex:params[:session][:sex],
                  phonenumber:params[:session][:phonenumber])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "注册成功: #{params[:session][:name]} :)"}
    end
    redirect_to root_url, :flash => flash
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
