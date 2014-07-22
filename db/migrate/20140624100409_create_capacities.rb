class CreateCapacities < ActiveRecord::Migration
  def up
    create_table :capacities do |t|
      t.string :name
      t.string :status
      t.integer :capacity
      t.integer :level_id
      t.integer :login_id

      t.timestamps
    end
  end

  def down
    drop_table :capacities
  end
end
