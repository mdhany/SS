class AddDefaultToCapacities < ActiveRecord::Migration
  def change
    change_column_default :capacities, :name, 'beginner'
    change_column_default :capacities, :status, 'inactive'
    change_column_default :capacities, :level_id, 1
  end
end
