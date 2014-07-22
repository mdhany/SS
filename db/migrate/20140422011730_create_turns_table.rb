class CreateTurnsTable < ActiveRecord::Migration
  def up
    create_table :turns do |t|
      t.integer :user_id
      t.integer :level_id
      t.text :status

      t.timestamps

    end
  end

  def down

    drop_table :turns

  end
end
