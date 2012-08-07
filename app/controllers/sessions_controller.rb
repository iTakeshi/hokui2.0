# coding: utf-8

class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by_user_email(params[:user_email])
    if user && user.authenticate(params[:password])
      cookies.permanent[:user_auth_token] = user.user_auth_token
      flash[:info] = 'ログインに成功しました！'
      redirect_to root_url
    else
      flash.now[:error] = 'メールアドレスまたはパスワード、あるいはその両方が不正です。'
      render action: :new
    end
  end
end
