class ModifiedIdentificationFromUsers < ActiveRecord::Migration
  def change
    #remove_column :users, :identification

    add_column :users, :identification, :integer, limit: 5

  end
end
