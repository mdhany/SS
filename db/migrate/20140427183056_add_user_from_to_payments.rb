class AddUserFromToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :user_from, :integer
  end
end
