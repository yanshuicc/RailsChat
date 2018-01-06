class FriendshipRequest < ApplicationRecord

  # 判断某个用户是否收到好友请求
  def self.searchFriendshipReq(get_user_id)
    FriendshipRequest.joins('INNER JOIN users as send_user ON friendship_requests.send_user_id = send_user.id')
        .joins('INNER JOIN users as get_user ON friendship_requests.get_user_id = get_user.id')
      .where(get_user_id: get_user_id, request_flag: 0).select('friendship_requests.id,send_user.name')
  end

  # 判断是否曾对某个用户发送过好友请求
  def self.notExistReq(sent_user_id, get_user_id)
    FriendshipRequest.where(send_user_id: sent_user_id, get_user_id: get_user_id, request_flag: 0).size==0
  end

  def self.refuseReq(req_id)
    FriendshipRequest.where(id: req_id).update(request_flag: 2)
  end


  def self.agreeReq(req_id)
    FriendshipRequest.where(id: req_id).update(request_flag: 1)
    res = FriendshipRequest.find(req_id)
    res.send_user_id
  end
end
