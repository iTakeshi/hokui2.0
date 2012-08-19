# coding: utf-8

class AdminMailer < ActionMailer::Base
  default from: "hokui93.net@gmail.com"
  require '/var/app/setting/hokui/server_name.rb'

  def notify_signup_request(admin, user)
    @server_name = hokui_server_name
    @user = user
    mail to: admin.user_email, subject: '北医ネット：新規ユーザー承認リクエスト'
  end
end
