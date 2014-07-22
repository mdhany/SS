class AddPaypalEmailToLogin < ActiveRecord::Migration
  def up
    add_column :logins, :paypal, :string
    add_column :logins, :skype, :string
    add_column :logins, :avatar, :string
  end

  def down
    remove_column :logins, :paypal
    remove_column :logins, :skype
    remove_column :logins, :avatar
  end
end
