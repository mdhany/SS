class AddTwoIndexToUsers < ActiveRecord::Migration
  def change
    add_index :users, :email, :unique => true
    add_index :users, :identification, :unique => true
    add_index :users, :number_account, :unique => true

    add_column :users, :account_type, :string
  end
end
