class AddMoreGatewaysToLogins < ActiveRecord::Migration
  def up
    remove_column :logins, :address
    add_column :logins, :account_type2, :integer
    add_column :logins, :number_account2, :integer
    add_column :logins, :account_type3, :integer
    add_column :logins, :number_account3, :integer
  end

  def down
    add_column :logins, :address, :string
    remove_column :logins, :account_type2
    remove_column :logins, :number_account2
    remove_column :logins, :account_type3
    remove_column :logins, :number_account3
  end
end
