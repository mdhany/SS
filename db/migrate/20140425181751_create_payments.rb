class CreatePayments < ActiveRecord::Migration
  def up
    create_table :payments do |t|
      t.integer :amount
      t.float :sent
      t.float :received
      t.text :gateway
      t.integer :turn_id
      t.integer :user_id


      t.timestamps
    end
  end

  def down
    delete :payments
  end
end
