class RemoveIndexOnUserEmailSub < ActiveRecord::Migration
  def up
    remove_index :users, :user_email_sub
  end

  def down
  end
end
