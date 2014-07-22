class AddReferredToTurn < ActiveRecord::Migration
  def change
    add_column :turns, :referred, :integer
  end
end
