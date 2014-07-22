class AddIdToLoginsPayments < ActiveRecord::Migration
  def up
    add_column :logins_payments, :id, :primary_key
  end

  def down
    remove_column :logins_payments, :id

  end
end
