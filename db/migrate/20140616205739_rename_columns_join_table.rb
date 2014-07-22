class RenameColumnsJoinTable < ActiveRecord::Migration
  def up
    rename_column :logins_payments, :payments_id, :payment_id
    rename_column :logins_payments, :logins_id, :login_id
  end

  def down
    rename_column :logins_payments, :payment_id, :payments_id
    rename_column :logins_payments, :login_id, :logins_id
  end
end
