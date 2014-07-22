class AddSelfAssociationInLogin < ActiveRecord::Migration
  def up
    add_reference :logins, :sponsor
  end

  def down
    remove_reference :logins, :sponsor
  end
end
