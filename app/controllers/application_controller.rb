class ApplicationController < ActionController::Base
  before_filter :authorize_as_user
  protect_from_forgery

private
  def authorize_as_user
    redirect_to '/login' unless current_user
    if cookies[:remember_me] == 'true'
      request.session_options[:expire_after] = 86400 * 30
    end
  end

  def current_user
    if session[:user_auth_token]
      User.find_by_user_auth_token(session[:user_auth_token])
    else
      nil
    end
  end
end
