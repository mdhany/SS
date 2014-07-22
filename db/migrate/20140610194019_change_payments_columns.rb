class ChangePaymentsColumns < ActiveRecord::Migration
  def up
    rename_column :payments, :user_from, :to_user
    change_column :payments, :sent, :boolean, default: 0
    change_column :payments, :received, :boolean, default: 0


  end

  def dow
    rename_column :payments, :to_user, :user_from
  end
end
