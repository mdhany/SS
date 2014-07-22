class AddUserFieldsIntoLogins < ActiveRecord::Migration
  def up
    add_column :logins, :username, :string
    add_column :logins, :first_name, :string
    add_column :logins, :last_name, :string
    add_column :logins, :identification, :string
    add_column :logins, :phone, :integer
    add_column :logins, :mobile, :integer
    add_column :logins, :number_account, :integer
    add_column :logins, :account_type, :string
    add_column :logins, :status, :string
    add_column :logins, :country, :string
    add_column :logins, :city, :string
    add_column :logins, :state, :string
    add_column :logins, :address, :string
    add_column :logins, :level_id, :integer

    add_index :logins, :username, :unique => true
    add_index :logins, :identification, :unique => true
    add_index :logins, :number_account, :unique => true
  end

  def down
    remove_column :logins, :username, :string
    remove_column :logins, :first_name, :string
    remove_column :logins, :last_name, :string
    remove_column :logins, :identification, :string
    remove_column :logins, :phone, :integer
    remove_column :logins, :mobile, :integer
    remove_column :logins, :number_account, :integer
    remove_column :logins, :account_type, :string
    remove_column :logins, :status, :string
    remove_column :logins, :country, :string
    remove_column :logins, :city, :string
    remove_column :logins, :state, :string
    remove_column :logins, :address, :string
    remove_column :logins, :level_id, :integer

    remove_index :logins, :username
    remove_index :logins, :identification
    remove_index :logins, :number_account


  end
end
