class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :user_family_name, :user_given_name, :user_handle_name,
                  :user_birthday, :user_email, :user_email_sub,
                  :password, :password_confirmation

  validates :user_family_name,
    presence: true

  validates :user_given_name,
    presence: true

  validates :user_handle_name,
    presence: true,
    length: { minimum: 3, maximum: 10, allow_blank: true }

  validates :user_birthday,
    presence: true

  validates :user_email,
    presence: true,
    uniqueness: { allow_blank: true },
    format: { with: /^[0-9a-zA-Z_\-\.\+]+@[a-z]+\.hokudai\.ac\.jp$/, allow_blank: true }

  validates :user_email_sub,
    uniqueness: { allow_blank: true },
    format: { with: /^[0-9a-zA-Z_\-\.\+]+@[0-9a-zA-Z_\-\.\+]+$/, allow_blank: true }

  validates :user_is_admin,
    inclusion: { in: [true, false] }

  validates :user_status,
    inclusion: { in: [0, 1, 2, 3] }

  validates :user_auth_token,
    presence: true

  validates :password,
    presence: true,
    length: { minimum: 5 },
    confirmation: true

end
