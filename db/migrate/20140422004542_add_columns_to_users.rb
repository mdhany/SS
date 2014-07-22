class AddColumnsToUsers < ActiveRecord::Migration
  def up
    add_column :users, :phone, :integer
    add_column :users, :mobile, :integer
    add_column :users, :number_account, :integer

  end

  def down
    remove_column :users, :phone
    remove_column :users, :mobile
    remove_column :users, :number_account

  end
end
