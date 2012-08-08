# coding: utf-8

class UsersController < ApplicationController
  skip_before_filter :authorize_as_user, only: [:new, :create, :confirm_email, :forget_password, :reset_password, :set_new_password, :create_new_password]

  # GET /signup
  def new
    @user = User.new
  end

  # POST /signup
  def create
    @user = User.new(params[:user])
    @user.user_is_admin = false
    @user.user_status = 1
    @user.generate_user_auth_token

    if @user.save
      @user.send_signup_confirmation_mail
      render
    else
      render action: :new
    end
  end

  # GET /users/confirm/:user_auth_token
  def confirm_email
    @error = false
    @user = User.find_by_user_auth_token(params[:user_auth_token])
    if @user.user_status != 1
      @error = 'already'
      render
      return
    end
    @user.user_status = 2
    @user.save!
    @user.request_for_admin_approval
  rescue
    @error = 'fatal'
    # TODO : report for admins
    render
  end

  # GET /users/index
  def index
    @admins = User.where(user_is_admin: true)
    @status1 = User.where(user_is_admin: false, user_status: 1)
    @status2 = User.where(user_is_admin: false, user_status: 2)
    @status3 = User.where(user_is_admin: false, user_status: 3)
    @status0 = User.where(user_is_admin: false, user_status: 0)
  end

  # GET /users/approve/:id
  def approve
    user = User.find(params[:id])
    raise unless user.user_status == 2
    user.user_status = 0
    user.save!
    user.send_approval_notification
    render json: { status: :success }
  rescue
    render json: { status: :error }
  end

  # GET /users/reject/:id
  def reject
    user = User.find(params[:id])
    raise unless user.user_status == 2
    user.delete
    user.send_rejection_notification
    render json: { status: :success }
  rescue
    render json: { status: :error }
  end

  # GET /reset_password
  def forget_password
    @dummy_user = User.new
  end

  # POST /reset_password
  def reset_password
    @dummy_user = User.new(params[:user])
    user = User.find_by_user_email(@dummy_user.user_email)
    if user && user.user_birthday == @dummy_user.user_birthday
      user.reset_password
      render
    else
      flash.now[:error] = 'メールアドレスまたは生年月日、あるいはその両方が不正です。'
      render action: :forget_password
    end
  end

  # GET /set_new_password/:user_auth_token/:user_secret_token
  def set_new_password
    user = User.find_by_user_auth_token(params[:user_auth_token])
    if user && user.user_secret_token == params[:user_secret_token]
      if user.user_status == 3
        if user.user_secret_token_expiration_time > Time.now
          @error = nil
          @user_auth_token = user.user_auth_token
        else
          @error = 'timeout'
        end
      else
        @error = 'bad_status'
      end
    else
      @error = 'fatal'
      # TODO : notify for admin
    end
  end

  # POST /set_new_password/:user_auth_token
  def create_new_password
    user = User.find_by_user_auth_token(params[:user_auth_token])
    @user_auth_token = user.user_auth_token
    raise if user.user_status != 3
    if params[:password].length >= 5
      if params[:password] == params[:password_confirmation]
        user.password = params[:password]
        user.user_secret_token = nil
        user.user_secret_token_expiration_time = nil
        user.user_status = 0
        user.save!
        flash.now[:info] = 'パスワードを再設定しました。'
        redirect_to '/login'
      else
        flash.now[:error] = 'パスワードの確認が一致しません。'
        render action: :set_new_password
      end
    else
      flash.now[:error] = 'パスワードは5文字以上で設定してください。'
      render action: :set_new_password
    end
  end

end
