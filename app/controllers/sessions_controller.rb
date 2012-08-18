# coding: utf-8

class SessionsController < ApplicationController
  skip_before_filter :authorize_as_user, only: [:new, :create]

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
        request.session_options[:expire_after] = 86400 * 30
      else
        cookies.permanent[:remember_me] = false
      end
      flash[:success] = 'ログインに成功しました！'
      if session[:requested_url]
        temp_url = session[:requested_url]
        session[:requested_url] = nil
        redirect_to temp_url
      else
        redirect_to root_url
      end
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
