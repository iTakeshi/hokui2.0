# coding: utf-8

class UserMailer < ActionMailer::Base
  default from: "hokui93.net@gmail.com"
  require '/var/app/setting/hokui/server_name.rb'

  def confirm_signup(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：新規登録を受け付けました'
  end

  def notify_approved(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：登録申請が承認されました'
  end

  def notify_rejected(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：登録申請が拒否されました'
  end

  def notify_promoted(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：管理者に昇格しました'
  end

  def notify_demoted(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：一般ユーザーに降格しました'
  end

  def notify_deleted(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：退会処理されました'
  end

  def notify_resetting_password(user)
    @server_name = hokui_server_name
    @user = user
    mail to: @user.user_email, subject: '北医ネット：パスワードを再設定します'
  end
end
