require 'test_helper'

class HomesControllerTest < ActionDispatch::IntegrationTest

  # 测试主界面
  test "get welcome index" do
    get '/'
    assert_response :success
    assert_select "h1", "A Warm Welcome to QChat!"
  end

  # 测试登录 发送消息
  test "should login as admin & send message" do
    post "/sessions/login",
         params: { 'session[email]': "admin@163.com",
                   'session[password]': "123456",
                   'session[remember_me]': 1
         }
    assert_response :redirect
    follow_redirect!
    assert_response :success
    # 登录成功的提示
    assert_equal '欢迎回来: admin :)', flash[:info]

    # 监测是否可以获取添加好友请求
    # 如果登录失败，会无法访问'/friendships/index_json'，跳转到'/'
    get "/friendships/index_json"
    assert_response :success
    assert '[]'

    #get '/managers/index'
    #assert_response :redirect
    #follow_redirect!
    #assert_response :success
    #assert_select 'h3', '欢迎来到用户信息管理中心'

    # 发送消息的测试
    post "/messages", params:{
        'message[body]':'消息测试',
        'chat_room': 1
    }
    assert_response :redirect
  end

end