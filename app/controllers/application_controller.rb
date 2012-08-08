# coding: utf-8

class ApplicationController < ActionController::Base
  before_filter :authorize_as_user
  protect_from_forgery

private
  def authorize_as_user
    unless current_user
      session[:requested_url] = request.url
      redirect_to '/login'
      return
    end
    if cookies[:remember_me] == 'true'
      request.session_options[:expire_after] = 86400 * 30
    end
  end

  def authorize_as_admin
    unless current_user.user_is_admin
      respond_to do |format|
        format.html { render status: 403, file: "#{Rails.root}/public/403.html" }
      end
    end
  end

  def classify_user_status(user)
    if user.user_status == 1
      flash[:error] = 'ELMSメールアドレスの確認が完了していません。ELMS受信BOXを確認してください。'
    elsif user.user_status == 2
      flash[:error] = '新規登録申請が承認されるのを待っています。承認されると、ELMSメール宛に通知されます。'
    elsif user.user_status == 3
      if user.user_secret_token_expiration_time < Time.now
        user.user_status = 0
        user.user_secret_token = nil
        user.user_secret_token_expiration_time = nil
        user.save
        flash[:error] = 'パスワード再設定手続きの途中でしたが、URLの有効期限切れでキャンセルされました。再度お試しください。'
      else
        flash[:error] = 'パスワード再設定手続きの途中です。ELMSメールアドレス宛に送信されたメールを確認してください。'
      end
    end
  end

  def current_user
    if session[:user_auth_token]
      user = User.find_by_user_auth_token(session[:user_auth_token])
      if user.user_status == 0
        user
      else
        classify_user_status(user)
        nil
      end
    else
      nil
    end
  end
end
