class CreateMessages < ActiveRecord::Migration
  def up
    create_table :messages do |t|
      t.text :message
      t.integer :uSent_ID
      t.integer :uReceived_ID

      t.references :users
      t.timestamps
    end
  end

  def down
    drop_table :messages
  end
end
