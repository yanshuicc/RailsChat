class ManagersController < ApplicationController
  include SessionsHelper

  before_action :correct_user
  before_action :set_user, only: [ :index_edit, :index_update, :destroy]

  def index
  	@users=User.all

    if params[:user_name].nil? or params[:user_name] == ''
    else 
      
      @users = @users.where("name like ?", "%#{params[:user_name]}%")
    end
    
    if params[:user_type].nil? or params[:user_type] == ''
    else 

      if(params[:user_type] == '1')
        @users = @users.where("role = ?", '1')
      else
        flash[:info] = '请检查您的输入是否由误！'
      end
    end
  end

  def show
    redirect_to :action => 'index'
  end

  def destroy
  	@user = User.find(params[:id])

    @messages_read_flag = Messages_read_flag.where("user_id = ?", params[:id])
    @messages_read_flag.each do |flag|
      @messages_flag = Messages_read_flag.where("message_id = ?", flag.message_id)
      @messages_flag.each do |flag_all|
        flag_all.destroy
      end
    end
    
    @messages = Message.where("user_id = ?", params[:id])
    @messages.each do |message|
      message.destroy
    end

    @chat_users = Chats_user.where("user_id = ?", params[:id])
    @chat_users.each do |chat_user|
      chat_user.destroy
    end

    @chats = Chat.where("admin_id = ?", params[:id])
    @chats.each do |chat|
      chat.destroy
    end
    @friendships = FriendshipRequest.where("send_user_id = ?", params[:id])
    @friendships.each do |friendship|
      friendship.destroy
    end
     @friends = Friendship.where("user_id = ?", params[:id])
    @friends.each do |friend|
      friend.destroy
    end
    @user.destroy
    
    redirect_to :action => 'index' 
  end

  def index_edit
  end

  def index_update
    @users=User.all

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
    @informations = Chats_user.joins(:user, :chat)
    
    if !params[:user_name].blank?
      @informations = @informations.where("users.name like ?", "%#{params[:user_name]}%")
    end
    if !params[:chat_name].blank?
      @informations = @informations.where("chats.name like ?", "%#{params[:chat_name]}%")
    end
    if !params[:chat_admin].blank?
      @informations = @informations.where("chats.admin_id like ?", "%#{params[:chat_admin]}%")
    end
    
  end

  def messages_show
    @msg_infoms = Message.joins(:user, :chat)

    if !params[:user_name].blank?
      @msg_infoms = @msg_infoms.where("users.name like ?", "%#{params[:user_name]}%")
    end
    if !params[:chat_name].blank?
      @msg_infoms = @msg_infoms.where("chats.name like ?", "%#{params[:chat_name]}%")
    end
    if !params[:key_word].blank?
      @msg_infoms = @msg_infoms.where("messages.body like ?", "%#{params[:key_word]}%")
    end
    if !params[:send_at].blank?
      @msg_infoms = @msg_infoms.where("messages.created_at like ?", "%#{params[:send_at]}%")
    end

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