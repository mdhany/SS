class AddDefaultValueToLevelId < ActiveRecord::Migration
  def change
    change_column_default :logins, :level_id, 1
    change_column_default :payments, :level_id, 1
    change_column_default :turns, :level_id, 1
  end
end
