# coding: utf-8

class SessionsController < ApplicationController
  # GET /login
  def new
  end

  # POST /login
  def create
    user = User.find_by_user_email(params[:user_email])
    if user && user.authenticate(params[:password])
      session[:user_auth_token] = user.user_auth_token
      if params[:remember_me]
        cookies.permanent[:remember_me] = true
        request.session_options[:expire_after] = 1.month.from_now
      else
        cookies.permanent[:remember_me] = false
      end
      flash[:info] = 'ログインに成功しました！'
      redirect_to root_url
    else
      flash.now[:error] = 'メールアドレスまたはパスワード、あるいはその両方が不正です。'
      render action: :new
    end
  end

  # GET /logout
  def delete
    session[:user_auth_token] = nil
    cookies.delete(:remember_me)
    flash[:info] = 'ログアウトしました。'
    redirect_to '/login'
  end
end
