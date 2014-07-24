class ChangeNumberAccountToString < ActiveRecord::Migration
  def up
    change_column :logins, :number_account, :string
  end

  def down
    change_column :logins, :number_account, :integer
  end
end
