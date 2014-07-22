class AddAssociationPaymentLogin < ActiveRecord::Migration
  def up
    add_column :payments, :login_id, :integer, null: false
    add_column :payments, :beneficiary, :integer, null: false
  end

  def down
    remove_column :payments, :login_id
    remove_column :payments, :beneficiary

  end
end
