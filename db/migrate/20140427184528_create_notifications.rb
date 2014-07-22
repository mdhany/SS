class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.boolean :read, default: 0
      t.string :message
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
