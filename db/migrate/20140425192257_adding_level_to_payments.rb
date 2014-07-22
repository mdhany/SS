class AddingLevelToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :level_id, :integer
  end
end
