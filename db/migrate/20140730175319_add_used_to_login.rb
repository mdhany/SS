class AddUsedToLogin < ActiveRecord::Migration
  def up
    add_column :logins, :used, :boolean, default: false
  end

  def down
    remove_column :logins, :used
  end
end
