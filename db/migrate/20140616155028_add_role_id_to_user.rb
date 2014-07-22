class AddRoleIdToUser < ActiveRecord::Migration
  def change
    add_column :logins, :role_id, :integer
  end
end
