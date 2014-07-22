class AddDefaultValueToTurn < ActiveRecord::Migration
  def change
      change_column_default :turns, :status, 'waiting'
  end
end
