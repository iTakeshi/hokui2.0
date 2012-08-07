# coding: utf-8

class UserMailer < ActionMailer::Base
  default from: "hokui93.net@gmail.com"

  def confirm_signup(user)
    @user = user
    mail to: @user.user_email, subject: '北医ネット：新規登録を受け付けました'
  end

  def notify_approved(user)
    @user = user
    mail to: @user.user_email, subject: '北医ネット：登録申請が承認されました'
  end

  def notify_rejected(user)
    @user =user
    mail to: @user.user_email, subject: '北医ネット：登録申請が拒否されました'
  end
end
