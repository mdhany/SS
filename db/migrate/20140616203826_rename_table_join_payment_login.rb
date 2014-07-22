class RenameTableJoinPaymentLogin < ActiveRecord::Migration
  def change
    rename_table :payments_logins, :logins_payments
  end
end
