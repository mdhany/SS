class ChangeColumnsTypesToLogins < ActiveRecord::Migration
  def up
    change_column :logins, :phone, :string
    change_column :logins, :mobile, :string
  end

  def down
    change_column :logins, :phone, :integer
    change_column :logins, :mobile, :integer
  end
end
