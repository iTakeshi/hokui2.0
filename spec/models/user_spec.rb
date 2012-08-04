# coding: utf-8

require 'spec_helper'

describe User do

  describe "validation:" do

    before(:all) do
      user = User.new(
        user_family_name:      '佐藤',
        user_given_name:       '春男',
        user_handle_name:      'hSatoh',
        user_birthday:         '1989-06-13',
        user_email:            'hoge@ec.hokudai.ac.jp',
        user_email_sub:        'hoge@hoge.fuga',
        password:              'foobar',
        password_confirmation: 'foobar'
      )
      user.user_is_admin = false
      user.user_status = 0
      user.user_auth_token = SecureRandom.urlsafe_base64(20)
      user.user_secret_token = SecureRandom.urlsafe_base64(20)
      user.user_secret_token_expiration_time = Time.now + 60*60*2
      user.save!
    end

    before(:each) do
      @user = User.new(
        user_family_name:      '山田',
        user_given_name:       '一郎',
        user_handle_name:      'iYamada',
        user_birthday:         '1991-05-27',
        user_email:            'sample_email@ec.hokudai.ac.jp',
        user_email_sub:        'sample.email.sub@hoge.fuga',
        password:              'hogehogefugafuga',
        password_confirmation: 'hogehogefugafuga'
      )
      @user.user_is_admin = true
      @user.user_status = 1
      @user.user_auth_token = SecureRandom.urlsafe_base64(20)
      @user.user_secret_token = SecureRandom.urlsafe_base64(20)
      @user.user_secret_token_expiration_time = Time.now + 60*60*2
    end

    context "with valid information" do
      it "should be valid" do
        @user.should be_valid
      end
    end

    context "without :user_family_name" do
      it "should not be valid" do
        @user.user_family_name = ""
        @user.should_not be_valid
      end
    end

    context "without :user_given_name" do
      it "should not be valid" do
        @user.user_given_name = ""
        @user.should_not be_valid
      end
    end

    context "without :user_handle_name" do
      it "should not be valid" do
        @user.user_handle_name = ""
        @user.should_not be_valid
      end
    end

    context "with too long :user_handle_name" do
      it "should not be valid" do
        @user.user_handle_name = "abcdefghijklmn"
        @user.should_not be_valid
        @user.user_handle_name = "山田佐藤木村池田齋藤伊藤藤原"
        @user.should_not be_valid
      end
    end

    context "with too short :user_handle_name" do
      it "should not be valid" do
        @user.user_handle_name = "a"
        @user.should_not be_valid
        @user.user_handle_name = "山田"
        @user.should_not be_valid
      end
    end

    context "without :user_birthday" do
      it "should not be valid" do
        @user.user_birthday = ""
        @user.should_not be_valid
      end
    end

    context "with nonexistent date for :user_birthday" do
      it "should not be valid" do
        @user.user_birthday = '1991-02-31'
        @user.should_not be_valid
      end
    end

    context "without :user_email" do
      it "should not be valid" do
        @user.user_email = ""
        @user.should_not be_valid
      end
    end

    context "domain of :user_email is not hokudai.ac.jp" do
      it "should not be valid" do
        @user.user_email = "sample_email@med.hokudai.ac.jp"
        @user.should be_valid
        @user.user_email = "sample.email@gmail.com"
        @user.should_not be_valid
      end
    end

    context ":user_email is not unique" do
      it "should not be valid" do
        @user.user_email = "hoge@ec.hokudai.ac.jp"
        @user.should_not be_valid
      end
    end

    context "without :user_email_sub" do
      it "should be valid" do
        @user.user_email_sub = ""
        @user.should be_valid
      end
    end

    context "with invalid :user_email_sub format" do
      it "should not be valid" do
        @user.user_email_sub = "sample_email@@gmail.com"
        @user.should_not be_valid
      end
    end

    context ":user_email_sub is not unique" do
      it "should not be valid" do
        @user.user_email_sub = "hoge@hoge.fuga"
        @user.should_not be_valid
      end
    end

    context "without :user_is_admin" do
      it "should not be valid" do
        @user.user_is_admin = nil
        @user.should_not be_valid
      end
    end

    context "without :user_status" do
      it "should not be valid" do
        @user.user_status = nil
        @user.should_not be_valid
      end
    end

    context ":user_status is not included in [0, 1, 2, 3]" do
      it "should not be valid" do
        @user.user_status = 4
        @user.should_not be_valid
      end
    end

    context "without :user_auth_token" do
      it "should not be valid" do
        @user.user_auth_token = ""
        @user.should_not be_valid
      end
    end

    context "without :user_secret_token and :user_secret_token_expiration_time" do
      it "should be valid" do
        @user.user_secret_token = ""
        @user.user_secret_token_expiration_time = ""
        @user.should be_valid
      end
    end

    context "without :password" do
      it "should not be valid" do
        @user.password = nil
        @user.password_confirmation = nil
        @user.should_not be_valid
      end
    end

    context "with too short :password" do
      it "should not be valid" do
        @user.password = "abc"
        @user.password_confirmation = "abc"
        @user.should_not be_valid
      end
    end

    context ":password is different from :password_confirmation" do
      it "should not be valid" do
        @user.password = "abcdef"
        @user.password_confirmation = "ghijkl"
        @user.should_not be_valid
      end
    end

    context "mass-assignment for accepted property" do
      it "should be accepted" do
        lambda{ User.new(
          user_family_name: 'Williams',
          user_given_name:  'John',
          user_handle_name: 'starwars',
          user_birthday:    '1932-02-08',
          user_email:       'j.w@ec.hokudai.ac.jp',
          user_email_sub:   'j.w@hoge.fuga',
          password:    'foobar',
          password_confirmation: 'foobar'
        ) }.should_not raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end

    context "mass-assignment for unaccepted property" do
      it "should not be accepted" do
        lambda{ User.new(user_is_admin: true) }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        lambda{ User.new(user_status: 0) }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        lambda{ User.new(user_auth_token: 'ABCabc') }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        lambda{ User.new(user_secret_token: 'AbCaBc') }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        lambda{ User.new(user_secret_token_expiration_time: Time.now + 60*60*24*30) }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
        lambda{ User.new(password_digest: 'a') }.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
      end
    end


  end
end
