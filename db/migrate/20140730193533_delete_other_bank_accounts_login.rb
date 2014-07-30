class DeleteOtherBankAccountsLogin < ActiveRecord::Migration
  def change
    remove_column :logins, :account_type2
    remove_column :logins, :number_account2
    remove_column :logins, :account_type3
    remove_column :logins, :number_account3
  end
end
