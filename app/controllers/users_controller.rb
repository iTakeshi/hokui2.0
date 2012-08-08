# coding: utf-8

class UsersController < ApplicationController
  skip_before_filter :authorize_as_user, only: [:new, :create, :confirm_email, :forget_password, :reset_password]

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
end
