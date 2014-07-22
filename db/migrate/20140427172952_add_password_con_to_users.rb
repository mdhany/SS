class AddPasswordConToUsers < ActiveRecord::Migration
  def change
    add_column :users, :password_confirmation, :string
    add_column :users, :status, :string

  end
end
