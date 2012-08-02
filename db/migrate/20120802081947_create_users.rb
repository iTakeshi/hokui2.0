class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_family_name, null: false
      t.string :user_given_name, null: false
      t.string :user_handle_name, null: false
      t.date :user_birthday, null: false
      t.string :user_email, null: false
      t.string :user_email_sub
      t.boolean :user_is_admin, null: false, default: false
      t.integer :user_status, null: false, default: 1
      t.string :user_auth_token, null: false
      t.string :user_secret_token
      t.datetime :user_secret_token_expiration_time
      t.string :password_digest, null: false

      t.timestamps
    end

    add_index :users, :user_email, unique: true
    add_index :users, :user_email_sub, unique: true
    add_index :users, :user_auth_token, unique: true
  end
end
