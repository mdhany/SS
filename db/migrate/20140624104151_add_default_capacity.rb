class AddDefaultCapacity < ActiveRecord::Migration
  def change
    change_column_default :capacities, :capacity, 1
  end
end
