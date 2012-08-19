# coding: utf-8

class User < ActiveRecord::Base
  has_secure_password
  has_many :materials
  attr_accessible :user_family_name, :user_given_name, :user_handle_name,
                  :user_birthday, :user_email, :user_email_sub,
                  :password, :password_confirmation

  validates :user_family_name,
    presence: { message: '氏を入力してください。' },
    length: { maximum: 15, allow_blank: true, message: '氏は15字以内で入力してください。' }

  validates :user_given_name,
    presence: { message: '名を入力してください。' },
    length: { maximum: 15, allow_blank: true, message: '名は15字以内で入力してください。' }

  validates :user_handle_name,
    presence: { message: 'ニックネームを入力してください。' },
    length: { minimum: 3, maximum: 10, allow_blank: true, message: 'ニックネームは3字以上、10字以内で入力してください。' }

  validates :user_birthday,
    presence: { message: '生年月日を入力してください。' }

  validates :user_email,
    presence: { message: 'ELMSメールアドレスを入力してください。' },
    uniqueness: { allow_blank: true, message: 'すでに同じELMSメールアドレスを利用しているユーザーが存在します。' },
    format: { with: /^[0-9a-zA-Z_\-\.\+]{,50}@(ec|med)\.hokudai\.ac\.jp$/, allow_blank: true, message: 'ELMSメールアドレスの形式が不正です。' }

  validates :user_email_sub,
    uniqueness: { allow_blank: true, message: 'すでに同じ携帯メールアドレスを利用しているユーザーが存在します。' },
    format: { with: /^[0-9a-zA-Z_\-\.\+]{,50}@[0-9a-zA-Z_\-\.]+$/, allow_blank: true, message: '携帯メールアドレスの形式が不正です。' }

  validates :user_is_admin,
    inclusion: { in: [true, false] }

  validates :user_status,
    inclusion: { in: [0, 1, 2, 3] }

  validates :user_auth_token,
    presence: true,
    uniqueness: { allow_blank: true }

  validates :user_secret_token,
    uniqueness: { allow_blank: true }

  validates :password,
    presence: { on: :create, message: 'パスワードを入力してください。' },
    length: { on: :create, minimum: 5, allow_blank: true, message: 'パスワードは5文字以上で設定してください。' },
    confirmation: { on: :create, message: 'パスワードの確認が一致しません' }

  def generate_user_auth_token
    begin
      self.user_auth_token = SecureRandom.urlsafe_base64(20)
    end while User.exists?(user_auth_token: self.user_auth_token)
  end

  def generate_user_secret_token
    begin
      self.user_secret_token = SecureRandom.urlsafe_base64(20)
    end while User.exists?(user_secret_token: self.user_secret_token)
    self.user_secret_token_expiration_time = Time.now + 86400
  end

  def send_signup_confirmation_mail
    UserMailer.confirm_signup(self).deliver
  end

  def request_for_admin_approval
    User.where(user_is_admin: true).select(:user_email).each do |admin|
      AdminMailer.notify_signup_request(admin, self).deliver
    end
  end

  def send_approval_notification
    UserMailer.notify_approved(self).deliver
  end

  def send_rejection_notification
    UserMailer.notify_rejected(self).deliver
  end

  def reset_password
    self.user_status = 3
    self.generate_user_secret_token
    self.save!
    UserMailer.notify_resetting_password(self).deliver
  end

end
