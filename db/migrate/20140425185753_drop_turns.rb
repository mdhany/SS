class DropTurns < ActiveRecord::Migration
  def up
    #drop_table :turns
  end

  def down
    create_table :turns do |t|
      t.integer :user_id
      t.integer :level_id
      t.text :status

      t.timestamps

    end
  end
end
