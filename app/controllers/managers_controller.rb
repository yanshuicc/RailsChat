class ManagersController < ApplicationController
  include SessionsHelper
  before_action :set_user, only: [ :index_edit, :index_update, :destroy]
  before_action :correct_user

  def index
  	@users=User.all
  end

  def show
    redirect_to :action => 'index'
  end

  def destroy
  	user = User.find(params[:id])
    user.destroy
    redirect_to :action => 'index' 
  end

  def index_edit
  end

  def index_update
    @users=User.all
    puts user_params

    if user_params[:name].nil? or user_params[:name] == ''
    else 
      @user.update_attribute(:name, user_params[:name])
    end

    if user_params[:email].nil? or user_params[:email] == ''
    else 
      @user.update_attribute(:email, user_params[:email])
    end

    if user_params[:role].nil? or user_params[:role] == ''
    else 
      @user.update_attribute(:role, user_params[:role])
    end

    if user_params[:sex].nil? or user_params[:sex] == ''
    else 
      @user.update_attribute(:sex, user_params[:sex])
    end

    if user_params[:phonenumber].nil? or user_params[:phonenumber] == ''
    else 
      @user.update_attribute(:phonenumber, user_params[:phonenumber])
    end

    if user_params[:status].nil? or user_params[:status] == ''
    else 
      @user.update_attribute(:status, user_params[:status])
    end
    
    redirect_to :action => 'index'
  end

  def chats_show
    @infomations = User.find_by_sql(["select  user_name, chat_name, description, users.name as admin_name
      from (select A.name as user_name, chats.name as chat_name, description, admin_id
      from (SELECT *
      FROM users
      INNER JOIN chats_users
      ON users.id = chats_users.user_id) as A
      inner join chats
      on A.chat_id = chats.id) as B
      inner join users
      on B.admin_id = users.id
      "])
  end

  def messages_show
    @msg_infoms = Message.find_by_sql(["select A.name as user_name, chats.name as chat_name, A.body as msg, A.created_at as create_time
        from (select *
        from messages
        inner join users
        on messages.user_id = users.id) as A
        inner join chats
        on chats.id = A.chat_id
      "])
  end

  def correct_user
    if current_user
      if current_user.role == 1
      else
        redirect_to root_path, flash: {warning: '您权限不够'}
      end
    else
      redirect_to root_path, flash: {warning: '您权限不够'}
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

     def user_params
      params.require(:user).permit(:name, :email, :role, :sex, :phonenumber, :status)
    end
end