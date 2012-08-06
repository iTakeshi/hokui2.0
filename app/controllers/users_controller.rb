# coding: utf-8

class UsersController < ApplicationController

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
    # TODO : report for admins
  rescue
    @error = 'fatal'
    # TODO : report for admins
    render
  end

end
