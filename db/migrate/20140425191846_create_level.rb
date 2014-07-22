class CreateLevel < ActiveRecord::Migration
  def up
    create_table :levels do |t|
      t.string :name
      t.text :description
      t.integer :amount
    end
  end

  def down
    drop_table :levels
  end
end
