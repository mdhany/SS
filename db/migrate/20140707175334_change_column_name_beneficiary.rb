class ChangeColumnNameBeneficiary < ActiveRecord::Migration
  def up
    rename_column :payments, :beneficiary, :beneficiary_id
  end

  def down
    rename_column :payments, :beneficiary_id, :beneficiary
  end
end
