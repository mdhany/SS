class ChangeAssociationLoginPayments < ActiveRecord::Migration
  def up
    create_table :payments_logins, id: false do |t|
      t.belongs_to :payments
      t.belongs_to :logins
    end
    remove_column :payments, :login_id
    remove_column :payments, :to_user
  end

  def down
    drop_table :payments_logins
    add_column :payments, :login_id, :integer
    add_column :payments, :to_user, :integer
  end
end
