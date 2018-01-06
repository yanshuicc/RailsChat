class FriendshipsController < ApplicationController
  include SessionsHelper
  before_action :logged_in
  respond_to  :html, :json

  def index
    if(FriendshipRequest.notExistReq(current_user.id, params[:friend_id]))
      fq = FriendshipRequest.new
      fq.send_user_id=current_user.id
      fq.get_user_id= params[:friend_id]
      fq.request_flag=0
      fq.save
    end
    flash[:info] = '好友申请已发送'
    redirect_to chats_path
  end

  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      flash[:info] = "添加好友成功"
      redirect_to chats_path
    else
      flash[:error] = "无法添加好友"
      redirect_to chats_path
    end
  end

  def agree
    if(params[:agree]==0)
      FriendshipRequest.refuseReq(params[:request_id])
      flash[:error] = '已经拒绝该请求添加好友'
    else
      friend_id=FriendshipRequest.agreeReq(params[:request_id])
      @friendship = current_user.friendships.build(:friend_id => friend_id)
      if @friendship.save
        flash[:info] = '添加好友成功'
      else
        flash[:error] = '无法添加好友'
      end
    end
    redirect_to chats_path
  end

  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy

    user=User.find_by_id(params[:id])
    current_user.chats.each do |chat|
      if (chat.users-[user, current_user]).blank?
        chat.destroy
      end
    end

    flash[:success] = "删除好友成功"
    redirect_to chats_path
  end


  def index_json
    @friendshipRequest=FriendshipRequest.searchFriendshipReq(current_user.id)
    render json: @friendshipRequest.as_json
  end


  private
  def logged_in
    unless logged_in?
      redirect_to root_url, flash: {danger: '请登陆'}
    end
  end



end
