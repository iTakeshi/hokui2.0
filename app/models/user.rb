class User < ActiveRecord::Base
  attr_accessible :password_digest, :user_auth_token, :user_birthday, :user_email, :user_email_sub, :user_family_name, :user_given_name, :user_handle_name, :user_is_admin, :user_secret_token, :user_secret_token_expiration_time, :user_status
end
