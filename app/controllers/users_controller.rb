# coding: utf-8

class UsersController < ApplicationController
  skip_before_filter :authorize_as_user, only: [:new, :create, :confirm_email, :forget_password, :reset_password, :set_new_password, :create_new_password]
  before_filter :authorize_as_admin, only: [:index, :approve, :reject, :demote, :promote, :delete]
  layout 'admin', only: :index

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

  # GET /users/demote/:id
  def demote
    user = User.find(params[:id])
    user.user_is_admin = false
    user.save!
    user.send_demotion_notification
    render json: { status: :success }
  rescue
    render json: { status: :error }
  end

  # GET /users/promote/:id
  def promote
    user = User.find(params[:id])
    user.user_is_admin = true
    user.save!
    user.send_promotion_notification
    render json: { status: :success }
  rescue
    render json: { status: :error }
  end

  # GET /users/delete/:id
  def delete
    user = User.find(params[:id])
    raise if user.user_is_admin
    user.delete
    user.send_deletion_notification
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

  # GET /edit_profile
  def edit
    @user = current_user
  end

  # PUT /edit_profile
  def update
    @user = current_user
    @user.user_handle_name = params[:user][:user_handle_name]
    @user.user_email_sub = params[:user][:user_email_sub]
    if @user.save
      flash[:success] = 'プロフィールを変更しました！'
      redirect_to '/edit_profile'
    else
      render action: :edit
    end
  end

  # GET /edit_password
  def edit_password
  end

  # POST /edit_password
  def update_password
    user = current_user
    if user.authenticate(params[:current_password])
      if params[:password] == params[:password_confirmation]
        if params[:password].length >= 5
          user.password = params[:password]
          user.save!
          flash[:info] = 'パスワードを変更しました。'
          redirect_to '/edit_profile'
        else
          flash.now[:error] = 'パスワードは5文字以上で設定してください。'
          render action: :edit_password
        end
      else
        flash.now[:error] = 'パスワードの確認が一致しません。'
        render action: :edit_password
      end
    else
      flash.now[:error] = '現在のパスワードが不正です。'
      render action: :edit_password
    end
  end

end
