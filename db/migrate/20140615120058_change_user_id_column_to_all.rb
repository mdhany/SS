class ChangeUserIdColumnToAll < ActiveRecord::Migration
  def up
    rename_column :messages, :users_id, :login_id
    rename_column :notifications, :user_id, :login_id
    rename_column :payments, :user_id, :login_id
    rename_column :turns, :user_id, :login_id
  end

  def down
    rename_column :messages, :login_id, :users_id
    rename_column :notifications, :login_id, :user_id
    rename_column :payments, :login_id, :user_id
    rename_column :turns, :login_id, :user_id
  end
end
